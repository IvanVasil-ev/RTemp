Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  root 'dashboard#index'

  # <-- Auth
  get '/login', to: 'auth#login', as: 'login'
  post '/login', to: 'api/auth#login'
  post '/logout', to: 'api/auth#logout', as: 'logout'
  get '/registration', to: 'auth#registration', as: 'registration'
  post '/registration', to: 'api/auth#registration'
  get '/forgot-password', to: 'auth#forgot_password', as: 'forgot_password'
  post '/forgot-password', to: 'api/auth#forgot_password'
  # -->

  resources :messages, only: %i[index show]
  resources :tasks, only: %i[index show]
  resources :groups, only: %i[index show]
  resources :users, only: %i[index show] do
    collection do
      get 'me', to: 'users#me', as: 'me'
      delete '', to: 'users#delete_selected', as: 'delete_selected'
    end
  end
  resources :reports, only: %i[index show]
  resources :settings, only: %i[index]
end
