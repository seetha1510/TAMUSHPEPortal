# frozen_string_literal: true

Rails.application.routes.draw do
  
  root 'users#index'

  resources :users
  resources :user_profiles
  resources :employees
  resources :employers

  get 'users/test', to: 'users#test', as: 'test'
  get 'users/show', to: 'users#show', as: 'show'
  get 'setting', to: 'users#setting', as: 'setting'

  #get '/account' => 'users#show', :as => :account_root

  devise_for :accounts, controllers: {omniauth_callbacks: 'accounts/omniauth_callbacks'}
  devise_scope :account do
    get 'accounts/sign_in', to: 'users#show', as: :new_account_session
    delete 'accounts/sign_out', to: 'accounts/sessions#destroy', as: :destory_account_session
  end

end
