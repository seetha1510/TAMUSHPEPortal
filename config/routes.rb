Rails.application.routes.draw do
  
  root "users#home"

  resource :users
  resource :user_profiles
  resource :employees 
  resource :employers

  get "users/test", to: "users#test", as: "test"

end
