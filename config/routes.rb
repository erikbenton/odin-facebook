Rails.application.routes.draw do

  root 					 		'static_pages#home'
  get		'/login' => 'static_pages#home'
  get		'/about' => 'static_pages#about'
  devise_for :users
  resources :users, only: [:index, :show]
end
