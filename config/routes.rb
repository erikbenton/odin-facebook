Rails.application.routes.draw do

  get 'likes/create'

  get 'likes/destroy'

  root 					 		'static_pages#home'
  get		'/login' => 'static_pages#home'
  get		'/about' => 'static_pages#about'
  
  devise_for :users
  # devise_for :users, controllers: { registrations: "registrations" }
  
  # Setting up route for getting notifications
  resources :users do
  	member do
  		get :notifications
  	end
  end
  resources :users, only: [:index, :show]

  # Setting up route for accepting friend requests
  resources :friendships do
  	member do
  		post :accept
  	end
  end

  # Posts routes
  resources :posts, only: [:create, :update, :destroy]

  # Likes routes
  resources :likes, only: [:create, :destroy]
  # resources :friendships, only: [:create, :destroy]
end
