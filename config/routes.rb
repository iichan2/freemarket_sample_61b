Rails.application.routes.draw do
  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                registrations: 'signup/new' }
  resources :categories, only: [:index]
  
  get 'cardDelete' => 'cards#delete', as: 'cardDelete'
  resources :cards, only: [:new,:delete] do
    collection do
      post 'pay', to: 'cards#pay'
    end
    member do
      post 'delete', to: 'cards#delete'
    end
  end

  devise_scope :user do
    get "sign_up", to: "users/registrations#new"
    get "sign_in", to: "users/sessions#new"
  #   # get "sign_out", to: "users/sessions#destroy" 
  end

  get 'buy' => 'items#pay', as: 'buy'
  get 'payjp' => 'signup#create_payjp', as: 'payjp'
  get 'item_stop' => 'items#item_stop', as: 'item_stop'
  get 'item_destroy' => 'items#item_destroy', as: 'item_destroy'
  post 'signup'  => 'signup#create', as: 'signup'

  resources :signup, only: [:new] do
    collection do
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
      get 'error_page'
    end
  end

  devise_scope :user do
    get "sign_up", to: "users/registrations#new"
    get "sign_in", to: "users/sessions#new"
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users do
    member do
      get "logout"
      get "payment"
      get "identification"
      get "trading"
      get "sending"
      get 'status_sell'
      get 'status_trading'
      get 'status_sold'
      get 'status_delivery'
      get 'status_bought'
      
  

    end

    # パン屑リスト
    resources :mypage do
      collection do
        get "mypage"
        get "logout"
        get "sending"
        get "payment"
        get "profil"
        get 'status_sell'
        get 'status_trading'
        get 'status_sold'
        get 'status_delivery'
        get 'status_bought'
        get "identification"
        get 'show'
      end
    end
  end
    root 'items#index'
    resources :items, only: [:index, :edit, :new, :create, :show] do
      member do
        get "saler"
        get 'transaction'
        post 'create_user'
        get 'get_category_children', defaults: { format: 'json' }
        get 'get_category_grandchildren', defaults: { format: 'json' }
        get 'bought'
        post 'item_stop'
        post 'item_destroy'
      end
      collection do
        get 'show_deleted'
        post 'comment_create'
        get 'error_page'
      end
  end
end
