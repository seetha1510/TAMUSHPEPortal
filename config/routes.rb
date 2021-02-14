Rails.application.routes.draw do
  

  root "users#home"

    resources :users
    resources :user_profiles
    resources :employees 
    resources :employers

  get "users/test", to: "users#test", as: "test"
  get "user_profiles/show", to: "user_profiles#show", as: "people"

end
