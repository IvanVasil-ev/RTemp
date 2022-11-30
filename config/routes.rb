Rails.application.routes.draw do
  root 'dashboard#index'

  get '/login', to: 'auth#login', as: 'login'
  get '/registration', to: 'auth#registration', as: 'registration'

  resources :messages, only: %i[index show]
  resources :tasks, only: %i[index show]
  resources :groups, only: %i[index show]
  resources :users, only: %i[index show]
  resources :reports, only: %i[index show]
  resources :settings, only: %i[index]
end
