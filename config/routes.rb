Rails.application.routes.draw do

  resources :rosters do
  	resources :tasks, except: :index
  end

	post '/tasks/:task_id/assign/:user_id', to: 'tasks#assign', as: 'assign_task'
	delete '/tasks/:task_id/unassign/:user_id', to: 'tasks#unassign', as: 'unassign_task'
	post '/tasks/:task_id/accept/:user_id', to: 'tasks#accept', as: 'accept_task'
	post '/notifications/:notification_id/dismiss', to: 'notifications#dismiss', as: 'dismiss_notification'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  resources :groups do
    get '/members', 								to: 'groups#members', 							as: 'members'
    post '/assign/:user_id', 				to: 'groups#assign', 								as: 'assign_user'
    post '/unassign/:user_id', 			to: 'groups#unassign', 							as: 'unassign_user'
    post '/make_administrator', 		to: 'groups#make_administrator', 		as: 'make_administrator'
    post '/remove_administrator', 	to: 'groups#remove_administrator', 	as: 'remove_administrator'
  end

	root 'dashboard#index'

  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'

  get     '/signup',  to: 'users#signup'
  post    '/signup',  to: 'users#signup_create'
end
