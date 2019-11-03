Rails.application.routes.draw do
  devise_for :users
  controllers: {
    registrations: 'users/registrations' ,
    omniauth_callbacks: 'users/omniauth_callbacks'
    }

  resources :users, only:[:new] do
    collection do
      get "tel"
      get "juusyo"
      get "card"
      get "ok"
      
    end
  end
    root 'tests#index'
  end
