Rails.application.routes.draw do

  root to: 'home#index'
  
  resources :sellers, only: [:index, :show]
  resources :vouchers, only: [:create, :show]

  get '/tos', to: 'home#tos', as: :tos
  get '/privacy', to: 'home#privacy', as: :privacy

  devise_for :admin_users, path: 'admin'

  namespace :admin do
    resources :users
    resources :admin_users
    resources :categories
    resources :sellers

    root to: "users#index"
  end


  authenticate :admin_user do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/admin/sidekiq'
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
