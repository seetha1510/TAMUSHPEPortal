Rails.application.routes.draw do
  
    root "user_profiles#index"

    resources :users
    resources :user_profiles
    resources :employees
    resources :employers

end
