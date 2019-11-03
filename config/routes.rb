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
  end
    root 'tests#index'
    resources :tests do
      collection do
        get 'transaction'
      end
  end
end
