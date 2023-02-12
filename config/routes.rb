Rails.application.routes.draw do
  resources :comments
  resources :posts

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get    '/user', to:'sessions#user' 
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
