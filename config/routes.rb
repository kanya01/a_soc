# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :audios do
    resources :comments, only: %i[create destroy]
  end

  resources :posts do
    post 'like', on: :member
    resources :comments, only: %i[create destroy]
  end
  get 'about', to: 'pages#about'
  get 'services', to: 'pages#services'
  get 'contact', to: 'pages#contact'
  get 'profile', to: 'users#profile'
  get 'settings', to: 'users#settings'

  root 'posts#index'
end
