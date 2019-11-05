Rails.application.routes.draw do
  devise_for :users
  resources :items, only: [:index,:new, :create]


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
    root 'tests#index'
    resources :tests do
      collection do
        get 'transaction'
      end
  end
end