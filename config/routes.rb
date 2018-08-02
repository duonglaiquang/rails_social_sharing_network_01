Rails.application.routes.draw do
  root "static_pages#home"
  get "/home", to: "static_pages#home"
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/search", to: "search#search"
  resources :users
  resources :account_activations, only: :edit
  resources :password_resets, except: %i(index show destroy)
  resources :posts, only: %i(create destroy)
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: %i(create destroy)
  namespace :admin do
    resources :users, only: %i(index destroy)
    resources :posts, only: %i(index destroy)
  end
end
