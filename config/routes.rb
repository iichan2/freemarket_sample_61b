Rails.application.routes.draw do
  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                registrations: 'users/registrations' }
  resources :categories, only: [:index]
  resources :cards
  
  # devise_scope :user do
  #   get "sign_up", to: "users/registrations#new"
  #   get "sign_in", to: "users/sessions#new"
  #   # get "sign_out", to: "users/sessions#destroy" 
  # end
  get 'payjp' => 'signup#create_payjp', as: 'payjp'
  post 'signup'  => 'signup#create', as: 'signup'
  resources :signup, only: [:new] do
    collection do
      get 'mail'
      get 'new'
      get 'tel'
      get 'address'
      get 'card'
      get 'newend' # ここで、入力の全てが終了する
      post 'create_user'
      get 'choice_new'
      get 'new_card'
      get 'show_card'
      post 'create_delivery'
    end
  end

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users do
    member do
      get "logout"
      get "payment"
      get "identification"
      get "trading"
      get "sending"
    end
  end
    root 'items#index'
    resources :items, only: [:index, :edit, :new, :create, :show] do
      member do
        get 'transaction'
        get 'get_category_children', defaults: { format: 'json' }
        get 'get_category_grandchildren', defaults: { format: 'json' }
        get 'bought'
      end
  end
end
