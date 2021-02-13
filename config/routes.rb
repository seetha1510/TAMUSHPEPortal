Rails.application.routes.draw do
  

  root "users#home"

    resources :users
    resources :user_profiles
    resources :employees 
    resources :employers

  get "users/test", to: "users#test", as: "test"

end
