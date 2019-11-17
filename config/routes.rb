Rails.application.routes.draw do
  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                registrations: 'signup/new' }
  resources :categories, only: [:index]
  resources :cards
  
  devise_scope :user do
    get "sign_up", to: "users/registrations#new"
    get "sign_in", to: "users/sessions#new"
  #   # get "sign_out", to: "users/sessions#destroy" 
  end
  get 'buy' => 'items#pay', as: 'buy'
  get 'payjp' => 'signup#create_payjp', as: 'payjp'
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
      # get "mypage"
    end

    # パン屑リスト
    resources :mypage do
      collection do
        get "mypage"
        get "logout"
        get "sending"
        get "payment"
        get "identification"
      end
    end
  end
    root 'items#index'
    resources :items, only: [:index, :edit, :new, :create, :show, :update] do
      collection do
        get "saler"
      end
      member do
        get 'transaction'
        post 'create_user'
        get 'get_category_children', defaults: { format: 'json' }
        get 'get_category_grandchildren', defaults: { format: 'json' }
        get 'bought'
      end
      collection do
        post 'comment_create'
      end
  end
end
