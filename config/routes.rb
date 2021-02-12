Rails.application.routes.draw do
  
  devise_for :accounts
    root "users#index"

    resources :users
    resources :user_profiles
    resources :employees 
    resources :employers

end
