Rails.application.routes.draw do
  # devise_for :users
  resources :users
  root 'tests#index' 
  resources :tests do
    collection do
      get 'transaction'
    end
  end
end
