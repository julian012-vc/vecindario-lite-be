Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # User
      get '/users', to: 'users#index'

      # Login

      # Projects
      

      # Leads

      # Reports
    end
  end

  get '/*a', to: 'application#not_found'

end
