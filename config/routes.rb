Rails.application.routes.draw do

  resources :rosters
  resources :users
  resources :account_activations, only: [:edit]

	root 'dashboard#index'

  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'
end
