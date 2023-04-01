Rails.application.routes.draw do
  devise_for :todo_users,
             controllers:{
                sessions: 'users/sessions',
                registrations: 'users/registrations',
                passwords: 'passwords',
             },
             defaults: {format: :json}
             
  get '/member-data', to: 'members#show'
  post '/passwords', to: 'passwords#create'
  put '/passwords/reset', to: 'passwords#update'
  get '/passwords/edit', to: 'passwords#edit'
  namespace :api do
    namespace :v1 do
      resources :todo_tasks
      get '/todo_tasks/:id/creator', to: 'todo_tasks#creator'
      get '/todo_tasks/:id/participants', to: 'todo_tasks#participants'
      get '/log', to: 'todo_tasks#log'
      get '/friendships', to: 'friendships#index'
      get '/friendships/requests', to: 'friendships#friend_request'
      get '/friendships/requests/count', to: 'friendships#friend_request_count'
      post '/friendships', to: 'friendships#create'
      put '/friendships/:id', to: 'friendships#update'
      delete '/friendships/:id', to: 'friendships#destroy'
      delete '/friendships', to: 'friendships#destroy'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
