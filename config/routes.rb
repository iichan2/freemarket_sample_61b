Rails.application.routes.draw do
  # devise_for :users
  resources :users do
    collection do
      get "tel"
      get "juusyo"
      get "card"
      get "ok"
      get "logout"
    end
    member do
      get "identification"
    end
  end
    root 'tests#index'
  end
