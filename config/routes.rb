Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  namespace :api do
    namespace :v1 do
      resources :accounts, only: [:index, :create]
      
      put "accounts/update", to: "accounts#update"
      post "login", to: "authenticate#create"
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
