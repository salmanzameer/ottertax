Rails.application.routes.draw do
  resources :documents
  get 'pages/home'
  devise_for :users, controllers: { sessions: "users/sessions" }
	as :user do
  	get 'login', to: 'devise/sessions#new'
	end

	get '/verify', to: 'pages#verify', as: :verify_code
	get '/invite', to: 'pages#invite', as: :invite_user
	get '/employer', to: 'pages#employer', as: :employer
	post '/send_invite', to: 'pages#send_invite', as: :send_invite_user
  root to: "pages#home"
end
