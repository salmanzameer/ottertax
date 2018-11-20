# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  prepend_before_action :check_captcha, only: [:create]

  def new
  	gon.rails_env = Rails.env
  	super	
  end

  private

  def check_captcha
    unless verify_recaptcha
      self.resource = resource_class.new
      resource.validate # Look for any other validation errors besides Recaptcha
      respond_with_navigational(resource) { render :new }
    end
  end
end
