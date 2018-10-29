Rails.application.routes.draw do
	root to: "documents#index"
  resources :documents do 
  	member do
  		get :email_doc
  		get :download_doc
  	end
  end
  
  get '/about', to: 'pages#about', as: :about
  
  devise_for :users, controllers: { sessions: "users/sessions" }
	as :user do
  	get 'login', to: 'devise/sessions#new'
	end

	get '/register', to: 'verifications#verify', as: :verify_code
	get '/invite', to: 'verifications#invite', as: :invite_user
	post '/send_invite', to: 'verifications#send_invite', as: :send_invite_user
end
