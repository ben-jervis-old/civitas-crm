Rails.application.routes.draw do

  resources :rosters do
  	resources :tasks, except: :index
  end

	post '/tasks/:task_id/assign/:user_id', to: 'tasks#assign', as: 'assign_task'
	post '/tasks/:task_id/accept/:user_id', to: 'tasks#accept', as: 'accept_task'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

	root 'dashboard#index'

  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'
end
