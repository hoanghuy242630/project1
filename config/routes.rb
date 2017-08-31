Rails.application.routes.draw do
  root "staticpages#home", to: "staticpages#home"
  get "staticpages/:page", to: "staticpages#show"
  post "/signup", to: "users#create"
  get "/signup", to: "users#new"
  resources :users
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :posts do
    resources :comments
  end

  resources :posts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
