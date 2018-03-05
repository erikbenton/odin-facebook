Rails.application.routes.draw do
  
  get 'users/index'

  get 'users/new'

  get 'users/create'

  get 'users/show'

  get 'users/edit'

  get 'users/update'

  get 'users/destroy'

  devise_for :users
  root 					 		'static_pages#home'
  get		'/login' => 'static_pages#home'
  get		'/about' => 'static_pages#about'

end
