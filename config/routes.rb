# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :accounts
  # root "users#home"
  root 'users#index'

  resources :users
  resources :user_profiles
  resources :employees
  resources :employers

  get 'users/test', to: 'users#test', as: 'test'
  get 'users/show', to: 'users#show', as: 'show'
  get 'setting', to: 'users#setting', as: 'setting'

  # namespace :account do
  #   root :to => "users#home"
  # end

  get '/account' => 'users#show', :as => :account_root
end
