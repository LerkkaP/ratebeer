Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs 
  resources :users
  resources :beers
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :styles
  resources :places, only: [:index, :show]
  resources :beer_clubs do
  resources :memberships, only: [:create, :destroy]
end
  root 'breweries#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  get 'places', to: 'places#index'
  post 'places', to: 'places#search'
  get 'beerlist', to: 'beers#list'
  get 'brewerylist', to: 'breweries#list'
  #get 'kaikki_bisset', to: 'beers#index'
  #get 'ratings', to: 'ratings#index'
  #get 'ratings/new', to:'ratings#new'
  #post 'ratings', to: 'ratings#create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]

  # Defines the root path route ("/")
  # root "articles#index"
end
