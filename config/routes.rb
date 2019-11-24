Rails.application.routes.draw do
  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'signup/new' }
  resources :categories, only: [:index]
  resources :delivery, only: [:update]
  
  resources :cards, only: [:new, :destroy] do
    collection do
      post 'pay', to: 'cards#pay'
      get 'error_page'
    end
  end

  devise_scope :user do
    get "sign_up", to: "users/registrations#new"
    get "sign_in", to: "users/sessions#new"
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :signup, only: [:new,:create] do
    collection do
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
      get 'status_trading'
      get 'status_sold'
      get 'status_delivery'
      get 'status_bought'
    end
  end
# パン屑
    resources :mypage do
      collection do
        get "mypage"
        get "logout"
        get "sending"
        get "payment"
        get "profil"
        get "edit"
        get 'status_sell'
        get 'status_trading'
        get 'status_sold'
        get 'status_delivery'
        get 'status_bought'
        get "identification"
        get 'show'
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