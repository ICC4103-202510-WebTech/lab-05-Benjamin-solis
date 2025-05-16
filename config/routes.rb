Rails.application.routes.draw do
  get "home/index"
  root "home#index"


  resources :users, only: [ :index, :show, :edit, :update ]
  resources :chats, only: [ :index, :show, :new, :create, :edit, :update ]
  resources :messages, only: [ :index, :show, :new, :create, :edit, :update ]
end
