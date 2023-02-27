Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      post '/signup', to: 'users#signup'
      post '/login', to: 'users#login'
      resources :coaches, except: [:new, :edit, :update]
      get '*a', to: 'users#not_found'
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
