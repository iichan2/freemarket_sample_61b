Rails.application.routes.draw do
  # devise_for :users
  resources :users
  root 'tests#index'
  end
