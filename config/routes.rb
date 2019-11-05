Rails.application.routes.draw do
  devise_for :users
  resources :items, only: [:index,:new, :create]

  resources :signup do
    collection do
      get 'new'
      get 'tel'
      get 'juusyo'
      get 'card'
      get 'ok' # ここで、入力の全てが終了する
    end
  end
  resources :users do
    collection do
      
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