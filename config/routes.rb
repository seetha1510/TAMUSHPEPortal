Rails.application.routes.draw do

  devise_for :accounts
    root "user_profiles#index"


    resources :users
    resources :user_profiles
    resources :employees
    resources :employers

end
