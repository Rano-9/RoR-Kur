Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "breweries#index"
  get "kaikki_bisset", to: "beers#index"
  
  #get 'ratings', to: 'ratings#index'
  #get 'ratings/new', to:'ratings#new'
  #post 'ratings', to: 'ratings#create'

  resources :ratings, only: [:index,:new,:create,:destroy]

  resource :session, only: [:new, :create, :destroy]

  resource :membership, only: [:new,:create,:destroy]

  resources :places, only: [:index, :show]
  post 'places', to: 'places#search'

  get "signup", to: "users#new"
  get "signin", to: "sessions#new"
  delete "signout", to: "sessions#destroy" 
  delete "delete", to: "ratings#destroy"



end
