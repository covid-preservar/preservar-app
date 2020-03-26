Rails.application.routes.draw do

  root to: 'home#index'

  resources :sellers, only: [:index, :show]
  resources :vouchers, only: [:create, :show] do
    resources :payments, only: [:new, :create]
  end


  get '/tos', to: 'home#tos', as: :tos
  get '/privacy', to: 'home#privacy', as: :privacy

  devise_for :seller_users,
             path: 'comerciante',
             controllers: { registrations: 'seller_users/registrations' },
             path_names: { sign_up: 'registo' }

  # TEMP - Until the seller login area is built
  get '/comerciante/bem-vindo', to: 'sellers#register_success', as: :register_success

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
    resources :seller_users

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
