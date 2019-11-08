Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :items, only: [:index,:new, :create]
  resources :categories

  resources :users do
    collection do
      get "tel"
      get "juusyo"
      get "card"
      get "ok"
      get "logout"
      get "payment"
    end
    member do
      get "identification"
    end
  end
    root 'items#index'
    resources :items do
      collection do
        get 'transaction'
      end
  end
end