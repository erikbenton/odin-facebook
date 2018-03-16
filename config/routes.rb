Rails.application.routes.draw do

  get 'likes/create'

  get 'likes/destroy'

  root 					 		'static_pages#home'
  get		'/login' => 'static_pages#home'
  get		'/about' => 'static_pages#about'
  get   '/timeline' => 'posts#index'
  
  # devise_for :users
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  
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
  resources :posts, only: [:index, :create, :update, :destroy]

  # Likes routes
  resources :likes, only: [:create, :destroy]

  # Comments routes
  resources :comments, only: [:create, :destroy]

  # resources :friendships, only: [:create, :destroy]
end
