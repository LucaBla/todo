Rails.application.routes.draw do
  devise_for :todo_users,
             controllers:{
                sessions: 'users/sessions',
                registrations: 'users/registrations'
             },
             defaults: {format: :json}
  get '/member-data', to: 'members#show'
  namespace :api do
    namespace :v1 do
      resources :todo_tasks
      get '/log', to: 'todo_tasks#log'
      get '/friendships', to: 'friendships#index'
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
