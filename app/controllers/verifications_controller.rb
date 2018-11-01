class VerificationsController < ApplicationController
  before_action :check_user

  def verify
    if request.xhr?
      code = SsnCode.where(ssn: params[:ssn], code: params[:code]).first
			if code.present? && code.user.blank?
				session[:verification_token] = Devise.friendly_token
				status, message, token, id = [400, "User verified successfully.", session[:verification_token], code.id]
			else
				status, message = [404, "The information you entered does not match our records. Please try again."]
			end
		
  		render json: { status: status, message: message, token: token, code_id: id }
  	end
  end

  def invite
  	unless check_auth_token
      flash[:notice] = "Please verify you ssn and security code."
      redirect_to verify_code_path
    end
  end

  def send_invite
    unless check_auth_token
      flash[:notice] = "Please verify you ssn and security code."
      redirect_to verify_code_path 
    else  
      user = User.where(email: params[:email]).first
      if user.present? 
        flash[:error] = "User with this email already present."
        redirect_to invite_user_path(auth_token: params[:auth_token], code_id: params[:code_id])
      else
        User.invite!(email: params[:email], ssn_code_id: params[:code_id])
      	session[:verification_token] = ''
      	flash[:success] = "An invitation has bee sent to your email."
      	redirect_to user_session_path
      end
    end
  end

  private
  
  def check_auth_token
  	(params[:auth_token].present? && (params[:auth_token] == session[:verification_token]))	
  end

  def check_user
  	if current_user.present?
	  	flash[:alert] = "You are not allowed to access this page"
	  	redirect_to documents_path
	  end
  end
end
