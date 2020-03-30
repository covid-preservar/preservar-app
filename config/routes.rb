Rails.application.routes.draw do
  # redirect www -> root (in production only)
  constraints(subdomain: 'www')do
    get '/', to: redirect("https://#{ENV.fetch('HOSTNAME') { 'preserve.pt' }}")
    get '*path', to: redirect("https://#{ENV.fetch('HOSTNAME') { 'preserve.pt' }}/%{path}")
  end

  # redirect herokuapp (in production only)
  if Rails.env.production? && !ENV.fetch('HOSTNAME').ends_with?('herokuapp.com')
    constraints(host: "#{ENV.fetch('HEROKU_APP_NAME') { 'preserve-prod' }}.herokuapp.com") do
      get '/', to: redirect("https://#{ENV.fetch('HOSTNAME') { 'preserve.pt' }}")
      get '*path', to: redirect("https://#{ENV.fetch('HOSTNAME') { 'preserve.pt' }}/%{path}")
    end
  end


  root to: 'home#index'

  resources :sellers, only: [:index, :show]
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

  # TEMP - Until the seller login area is built
  get '/comerciante/bem-vindo', to: 'sellers#register_success', as: :register_success

  namespace :webhooks do
    get 'payment/eupago', to:'eu_pago#webhook'
  end

  devise_for :admin_users, path: 'admin'

  namespace :admin do
    resources :admin_users
    resources :categories
    resources :sellers do
      member do
        patch :publish
        patch :unpublish
      end
    end
    resources :seller_users, except: [:destroy]
    resources :vouchers

    root to: "sellers#index"
  end


  authenticate :admin_user do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/admin/sidekiq'
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
