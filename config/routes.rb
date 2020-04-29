Rails.application.routes.draw do
  # redirect herokuapp (in production only)
  if Rails.env.production? && !ENV.fetch('HOSTNAME').ends_with?('herokuapp.com')
    constraints(host: "#{ENV.fetch('HEROKU_APP_NAME') { 'preserve-prod' }}.herokuapp.com") do
      get '/', to: redirect("https://#{ENV.fetch('HOSTNAME') { 'preserve.pt' }}")
      get '*path', to: redirect("https://#{ENV.fetch('HOSTNAME') { 'preserve.pt' }}/%{path}")
    end
  end

  # Partner subdomains
  constraints(->(req){ req.subdomain.present? && Subdomains::Partner.matches?(req) }) do
    get '/', to: 'partners#index'
    get :search, to: 'partners#search', constraints: { format: :js }, as: :partner_search
    get :tos, to: 'partners#tos', as: :partner_tos
    get :faq, to: 'partners#faq', as: :partner_faq

    devise_scope :seller_user do
      get '/comerciante/registo', to: 'seller_users/partner_registrations#new', as: :new_partner_signup
      post '/comerciante', to: 'seller_users/partner_registrations#create', as: :partner_signup
    end

    get '*path', to: redirect("https://#{ENV.fetch('HOSTNAME') { 'preserve.pt' }}/%{path}")
  end

  # Other subdomains are redirected
  constraints(->(req){ req.host != ENV['HOSTNAME'] &&
                       req.subdomain.present? &&
                       !req.subdomain.in?(Subdomains::Partner.subdomains)}) do
    get '/', to: redirect("https://#{ENV.fetch('HOSTNAME') { 'preserve.pt' }}")
    get '*path', to: redirect("https://#{ENV.fetch('HOSTNAME') { 'preserve.pt' }}/%{path}")
  end

  ### Fix some shared URLs that are 404s
    get '/Compre', to: redirect('/')
    get '/.', to: redirect('/')
    get '/*', to: redirect('/')
  ###

  constraints(host: ENV['HOSTNAME']) do
    root to: 'home#index'

    resources :places, only: [:index, :show]
    resources :vouchers, only: [:create, :show] do
      resources :payments, only: [:new, :create]

      get '/obrigado', to: 'payments#done', as: :thank_you, on: :member
    end

    get '/tos', to: 'home#tos', as: :tos
    get '/tos_mbway', to: 'home#tos_mbway', as: :tos_mbway
    get '/privacy', to: 'home#privacy', as: :privacy

    devise_for :seller_users,
              path: 'comerciante',
              controllers: { registrations: 'seller_users/registrations',
                             sessions: 'seller_users/sessions'},
              path_names: { sign_up: 'registo' }


    namespace :seller do
      resource :account, only: [:show] do
        put 'accept_new_terms'
      end
      resources :places, except: [:index, :destroy]

    end

    # TEMP - Until the seller login area is built
    get '/comerciante/bem-vindo', to: 'places#register_success', as: :register_success

    namespace :webhooks do
      get 'payment/eupago', to:'eu_pago#webhook'
    end

    devise_for :admin_users, path: 'admin'

    namespace :admin do
      resources :admin_users
      resources :categories
      resources :csv_imports, except: [:edit, :update]
      resources :payment_notifications, only: [:index, :show]
      resources :sellers
      resources :partners
      resources :partnerships
      resources :partner_identifiers, only: [:index, :show]
      resources :places do
        member do
          patch :publish
          patch :unpublish
        end
      end
      resources :seller_users
      resources :vouchers do
        patch :resend, on: :member
        patch :mark_refunded, on: :member
      end

      get 'stats', to: 'stats#index', as: :stats
      root to: "stats#index"
    end
  end


  authenticate :admin_user do
    require 'sidekiq/web'
    require 'sidekiq/cron/web'
    mount Sidekiq::Web => '/admin/sidekiq'
    mount Flipper::UI.app(Flipper) => '/admin/flipper'
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
