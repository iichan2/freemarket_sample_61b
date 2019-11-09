Rails.application.routes.draw do
  devise_for :users


  post 'signup'  => 'signup#create', as: 'signup'
  # as: Prefixを指定

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

  resources :users do
    collection do
      
      get "logout"
      get "payment"
    end
    member do
      get "identification"
    end
  end
    root 'items#index'
    resources :items do
      collection do
        get 'transaction'
        get 'get_category_children', defaults: { format: 'json' }
        get 'get_category_grandchildren', defaults: { format: 'json' }
      end
  end
end