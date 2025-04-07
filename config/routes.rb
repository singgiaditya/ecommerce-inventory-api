Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  #
  # Define authentication route
  post "/login", to: "authentication#login"
  # Define user route
  resources :user
  resources :categories
  resources :products, param: :product_id do
    post "update-stock", on: :collection
    get "search", on: :collection
  end
  get "/inventory/value", to: "products#inventory_value"
  resources :promotions
  resources :product_promotions
end
