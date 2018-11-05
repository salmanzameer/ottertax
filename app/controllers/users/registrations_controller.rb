class Users::RegistrationsController < Devise::RegistrationsController
	protected

  def update_resource(resource, params)
  	return super if (params["current_password"]&.present? || params["password"]&.present? || params["password_confirmation"]&.present?) 
  	resource.update_without_password(params.except("current_password"))
  end

  def after_update_path_for(resource)
    documents_path
  end
  
  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end