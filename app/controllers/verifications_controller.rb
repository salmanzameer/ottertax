class VerificationsController < ApplicationController
  before_action :check_user

  def verify
    if request.xhr?
      code = SsnCode.where(ssn: params[:ssn], code: params[:code]).first
			if code.present?
				session[:verification_token] = Devise.friendly_token
				status, message, token = [400, "User verified successfully.", session[:verification_token]]
			else
				status, message = [404, "ssn or access code is not verified."]
			end
		
  		render json: { status: status, message: message, token: token }
  	end
  end

  def invite
  	check_auth_token
  end

  def send_invite
  	check_auth_token

  	User.invite!(email: params[:email])
  	session[:verification_token] = ''
  	flash[:success] = "An invitation has bee sent to your email."
  	redirect_to user_session_path
  end

  private
  
  def check_auth_token
  	unless (params[:auth_token].present? && (params[:auth_token] == session[:verification_token]))
  		flash[:notice] = "Please verify you ssn and security code."
  		redirect_to verify_code_path 
  	end
  end

  def check_user
  	if current_user.present?
	  	flash[:alert] = "You are not allowed to access this page"
	  	redirect_to documents_path
	  end
  end
end
