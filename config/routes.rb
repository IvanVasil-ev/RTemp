Rails.application.routes.draw do
  root 'dashboard#index'

  resources :messages, only: %i[index show]
  resources :tasks, only: %i[index show]
  resources :groups, only: %i[index show]
  resources :users, only: %i[index show]
  resources :reports, only: %i[index show]
  resources :settings, only: %i[index]
end
