Rails.application.routes.draw do
  root 'items#new'
  devise_for :users
  resources :users
  resources :items, only: [:index,:new, :create]
  end
