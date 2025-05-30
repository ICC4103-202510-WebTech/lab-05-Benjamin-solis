Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users do
    resources :chats, only: [:index]
    resources :messages, only: [:index]
  end
  resources :chats
  resources :messages
  root "home#index"
end
