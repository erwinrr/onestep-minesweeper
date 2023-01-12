Rails.application.routes.draw do
   # Defines the root path route ("/")
   root "boards#new"
   
  resources :boards
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
