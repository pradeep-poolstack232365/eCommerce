Rails.application.routes.draw do

  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :products
  resources :users

  post "/auth/login", to: "authentication#login"

  resources :passwords, only: [:update]
 


  # get 'password_reset_confirmation', to: 'password_resets#show_error', as: 'show_password_reset'

  resources :password_resets do
   get :show_error, on: :collection
   get :edit_error, on: :collection
    
  end


  # resources :carts

  post "/add_product/:id", to: "carts#add_product"

  delete "/remove_product/:id", to: "carts#remove_product"



  # resources :carts do
  #   member do
  #     post 'add_product'
  #     delete 'remove_product'
  #   end
  # end


  # resources :carts  do
  #   post :add_product, on: :member
  #   delete :remove_product, on: :member
    
  # end

  # resources :carts, only: [:show,:post,:delete]


   resources :orders

   resources :addresses

end
