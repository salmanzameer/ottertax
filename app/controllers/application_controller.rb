# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :set_google_captcha

  protected

  def set_google_captcha
    gon.google_captcha = ENV['GOGGLE_CAPTCHA']
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || documents_path
  end
end
