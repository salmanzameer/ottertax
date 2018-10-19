class PagesController < ApplicationController
	before_action :authenticate_user!, except: [:verify, :invite]	  
  def home
  end

  def verify
  	if request.xhr?
  		if verify_recaptcha
  			code = SsnCode.where(ssn: params[:ssn], code: params[:code]).first
  			if code.present?
  				session[:verification_token] = Devise.friendly_token
  				status, message, token = [400, "User verified successfully.", session[:verification_token]]
  			else
  				status, message = [404, "ssn or access code is not verified."]
  			end
  		else
  			status, message = [404, "Captcha not verified."]
  		end

  		render json: { status: status, message: message, token: token }
  	end
  end

  def invite
  	binding.pry
  	unless (params[:auth_token].present? && (params[:auth_token] == session[:verification_token]))
  		flash[:notice] = "Please verify you ssn and security code."
  		redirect_to verify_code_path 
  	end
  end

  def send_invite
  	
  end
end