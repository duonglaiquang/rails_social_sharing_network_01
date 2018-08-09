Rails.application.routes.draw do
  root "static_pages#home"
  get "/home", to: "static_pages#home"
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/search", to: "search#search"
  get "auth/:provider/callback", to: "omniauth_callbacks#create"
  get "auth/failure", to: "omniauth_callbacks#failure"
  resources :users
  resources :account_activations, only: :edit
  resources :password_resets, except: %i(index show destroy)
  resources :posts, only: %i(create show destroy)
  resources :users do
    member do
      get :following, :followers
    end
  end
  resource :relationships, only: %i(create destroy)
  resources :comments, except: %i(index)

  namespace :admin do
    resources :users, only: %i(index destroy)
    resources :posts, only: %i(index destroy)
  end

  resources :tags, only: %i(show)
end
