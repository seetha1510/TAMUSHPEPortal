Rails.application.routes.draw do
  
  root "users#index"

  resources :users
  resources :user_profiles
  resources :employees 
  resources :employers

end
