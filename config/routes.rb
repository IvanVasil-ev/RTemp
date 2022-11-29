Rails.application.routes.draw do
  root 'dashboard#index'

  resources :messages, only: %i[index show]
  resources :tasks, only: %i[index show]
end
