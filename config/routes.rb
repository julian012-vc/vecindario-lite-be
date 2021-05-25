Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      # User
      get '/users', to: 'users#index'

      # Auth
      post '/auth/create', to: 'authentication#create'
      post '/auth/login', to: 'authentication#login'

      # Projects
      post '/projects', to: 'projects#create'
      get '/projects', to: 'projects#list'
      get '/projects/:id', to: 'projects#retrieve'

      # Leads

      # Reports
    end
  end

  get '/*a', to: 'application#not_found'

end
