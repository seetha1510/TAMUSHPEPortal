Rails.application.routes.draw do

  devise_for :accounts
    #root "users#home"
    root "users#index"
  
    resources :users
    resources :user_profiles
    resources :employees
    resources :employers

  get "users/test", to: "users#test", as: "test"
  get "users/home", to: "users#home", as: "home"

# namespace :account do
#   root :to => "users#home"
# end

  get '/account' => "users#home", :as => :account_root

end
