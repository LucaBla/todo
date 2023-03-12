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
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
