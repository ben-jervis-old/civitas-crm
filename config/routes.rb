Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	root 'dashboard#index'

	get '/users', to: "users#index"
  get '/users/:id', to: "users#show"
end
