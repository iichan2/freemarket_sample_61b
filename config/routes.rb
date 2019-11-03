Rails.application.routes.draw do
  root 'items#new'
  resources :items, only: [:index,:new, :create]
  # devise_for :users
  # resources :users do
  #   collection do
  #     get "tel"
  #     get "juusyo"
  #     get "card"
  #     get "ok"
  #     get "logout"
  #   end
  # ends
end
