# frozen_string_literal: true

Rails.application.routes.draw do

  resources :user_profiles, only: [:index, :edit, :update] do
    member do
      delete 'delete_image/:image_id', action: 'delete_image', as: 'delete_image'
    end
  end
  # root "users#home"
  root 'users#index'

  resources :users
  resources :user_profiles
  resources :employees
  resources :employers
  resources :students
  resources :schools

  get 'users/test', to: 'users#test', as: 'test'
  get 'users/show', to: 'users#show', as: 'show'
  get 'setting', to: 'users#setting', as: 'setting'
  get 'approval', to: 'users#approval', as: 'approval'


  #admin routes
  get 'admin', to: 'admins#home', as: 'admin'

  get 'admin/committees', to: 'admins#committees', as: 'admin_committees'
  post 'admin/committees/new', to: 'admins#committees_new', as: 'admin_committees_new'
  post 'admin/committees/add/:id', to: 'admins#committees_add_member', as: 'admin_committees_add_member'
  get 'admin/committees/remove/:id', to: 'admins#committees_remove_member', as: 'admin_committees_remove_member'

  get 'admin/requests', to: 'admins#requests', as: 'admin_account_requests'
  get 'admin/request/approve/:id', to: 'admins#request_approve', as: 'admin_request_approve'
  get 'admin/request/deny/:id', to: 'admins#request_deny', as: 'admin_request_deny'

  get 'admin/emails', to: 'admins#emails', as: 'admin_preapproved_emails'
  get 'admin/email/add', to: 'admins#email_add', as: 'admin_email_add'
  get 'admin/email/remove/:id', to: 'admins#email_remove', as: 'admin_email_remove'

  get 'admin/approved', to: 'admins#approved', as: 'admin_approved_users'
  get 'admin/approved/user/:id', to: 'admins#approved_view', as: 'admin_approved_view'
  get 'admin/approved/user/edit/:id', to: 'admins#approved_edit', as: 'admin_approved_edit'
  get 'admin/approved/user/delete/:id', to: 'admins#approved_delete', as: 'admin_approved_delete'



  #get '/account' => 'users#show', :as => :account_root

  devise_for :accounts, controllers: {omniauth_callbacks: 'accounts/omniauth_callbacks'}
  devise_scope :account do
    get 'accounts/sign_in', to: 'users#show', as: :new_account_session
    delete 'accounts/sign_out', to: 'accounts/sessions#destroy', as: :destory_account_session
  end
end
