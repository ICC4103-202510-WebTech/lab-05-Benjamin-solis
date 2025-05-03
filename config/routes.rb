Rails.application.routes.draw do
  root 'users#index'

  resources :users, only: [:index, :show]
  
  # Aquí se agregan las rutas para crear un nuevo chat
  resources :chats, only: [:index, :show, :new, :create]

  resources :messages, only: [:index, :show]
end
