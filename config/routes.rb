Rails.application.routes.draw do
  get 'posts/new'
  get 'posts/create'
  get 'posts/index'
	root 'static_pages#home'

  get '/', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'
	
	get '/signup', to: 'users#new'
	post '/signup', to: 'users#create'

	get '/login', to: 'sessions#new'
	post '/login', to: 'sessions#create'

	delete '/logout', to: 'sessions#destroy'

	resources :users
	resources :posts, only: [:new,:create, :index]


end
