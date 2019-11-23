Rails.application.routes.draw do
  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'signup/new' }
  resources :categories, only: [:index]
  resources :delivery, only: [:update]
  resources :cards, only: [:new, :destroy] do
    collection do
      post 'pay', to: 'cards#pay'
    end
  end

  devise_scope :user do
    get "sign_up", to: "users/registrations#new"
    get "sign_in", to: "users/sessions#new"
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get 'payjp' => 'signup#create_payjp', as: 'payjp'
  post 'signup'  => 'signup#create', as: 'signup'

  resources :signup, only: [:new] do
    collection do
      get 'new'
      get 'tel'
      get 'address'
      get 'card'
      get 'newend'
      post 'create_user'
      get 'choice_new'
      get 'new_card'
      get 'show_card'
      get 'error_page'
    end
  end

  resources :users, only: [:show, :edit, :update] do
    member do
      get "logout"
      get "payment"
      get "identification"
      get 'status_sell'
      get 'status_sell_trading'
      get 'status_sold'
      get 'status_buy_trading'
      get 'status_bought'
    end
  end
# パン屑
  resources :mypage, only: [:show, :edit] do
    collection do
      get 'status_sell'
      get 'status_sell_trading'
      get 'status_sold'
      get 'status_buy_trading'
      get 'status_bought'
      get "payment"
      get "identification"
      get "logout"
    end
  end

  root 'items#index'
  resources :items do
    member do
      get "saler"
      get 'transaction'
      post 'create_user'
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'bought'
      get 'item_stop'
      get 'item_start'
      get 'pay'
    end
    collection do
      get 'show_deleted'
      post 'comment_create'
      get 'error_page'
    end
  end
end