Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' ,omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :items, only: [:index,:new, :create]
  resources :categories

  post 'signup'  => 'signup#create', as: 'signup'


  resources :signup do
    collection do
      get 'mail'
      get 'new'
      get 'tel'
      get 'address'
      get 'card'
      get 'newend' # ここで、入力の全てが終了する
    end
  end

  resources :users, only: [:index, :edit] do
    member do
      get "logout"
      get "payment"
      get "identification"
    end
  end
    root 'items#index'
    resources :items, only: [:index, :edit, :new, :create, :show] do
      collection do
        get 'transaction'
      end
  end
end
