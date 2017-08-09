Rails.application.routes.draw do

  resources :rosters
  resources :users
  resources :account_activations, only: [:edit]

  resources :groups do
    get '/members', to: 'groups#members', as: 'members'
    get '/assign', to: 'groups#assign', as: 'assign'
    get '/unassign', to: 'groups#unassign', as: 'unassign'
    get '/make_administrator', to: 'groups#make_administrator', as: 'make_administrator'
    get '/remove_administrator', to: 'groups#remove_administrator', as: 'remove_administrator'
  end

	root 'dashboard#index'

  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'
end
