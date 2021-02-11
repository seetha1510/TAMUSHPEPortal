Rails.application.routes.draw do
  
  root "users#index"

  resource :users
  resource :user_profiles
  resource :employees 
  resource :employers

end
