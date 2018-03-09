Rails.application.routes.draw do

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
end
