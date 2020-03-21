Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'


  get '/tos', to: 'home#tos', as: :tos_path
  get '/privacy', to: 'home#privacy', as: :privacy_path
end
