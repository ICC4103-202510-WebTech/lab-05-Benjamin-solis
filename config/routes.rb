Rails.application.routes.draw do
  root 'users#index' 
  
  resources :users, only: [:index, :show]
  resources :chats, only: [:index, :show]
  resources :messages, only: [:index, :show]
end
