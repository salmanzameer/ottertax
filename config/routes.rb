Rails.application.routes.draw do
	root to: "documents#index"
  resources :documents do 
  	member do
  		get :download_doc
  	end

    collection do
      post :email_doc 
    end
  end
  
  resources :user

  get '/about', to: 'pages#about', as: :about
  
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
	as :user do
  	get 'users/edit' => 'users/registrations#edit', :as => 'edit_user_registration'    
  	put 'users' => 'users/registrations#update', :as => 'user_registration'  
	end

	get '/register', to: 'verifications#verify', as: :verify_code
	get '/invite', to: 'verifications#invite', as: :invite_user
	post '/send_invite', to: 'verifications#send_invite', as: :send_invite_user
end
