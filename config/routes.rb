Rails.application.routes.draw do
  root 'items#new'
  resources :items, only: [:index,:new, :create]
  # devise_for :users

  resources :users do
    collection do
      get "tel"
      get "juusyo"
      get "card"
      get "ok"
      get "logout"
      get "payment"
    end
  end
    root 'tests#index'
    resources :tests do
      collection do
        get 'transaction'
      end
  end
end
