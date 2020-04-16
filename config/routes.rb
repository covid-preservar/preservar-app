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

  root to: 'home#index'

  ### Fix some shared URLs that are 404s
    get '/Compre', to: redirect('/')
    get '/.', to: redirect('/')
    get '/*', to: redirect('/')
  ###

  resources :places, only: [:index, :show]
  resources :vouchers, only: [:create, :show] do
    resources :payments, only: [:new, :create]

    get '/obrigado', to: 'payments#done', as: :thank_you, on: :member
  end

  get '/tos', to: 'home#tos', as: :tos
  get '/privacy', to: 'home#privacy', as: :privacy

  devise_for :seller_users,
             path: 'comerciante',
             controllers: { registrations: 'seller_users/registrations' },
             path_names: { sign_up: 'registo' }


  namespace :seller do
    resource :account, only: [:show]
    resources :places, except: [:index, :destroy] do
      member do
        get :enable_discount
        post :confirm_discount
        get :disable_discount
        post :confirm_disable_discount
      end
    end
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
    resources :payment_notifications, only: [:index, :show]
    resources :sellers
    resources :add_on_partners
    resources :charity_partners
    resources :marketing_partners
    resources :partnerships
    resources :partner_identifiers, only: [:index, :show]
    resources :places do
      member do
        patch :publish
        patch :unpublish
      end
    end
    resources :seller_users
    resources :vouchers

    get 'stats', to: 'stats#index', as: :stats
    root to: "stats#index"
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
