class PagesController < ApplicationController
	before_action :authenticate_user!, except: [:verify, :invite, :send_invite]
	
  def home
  	@documents = Document.all
  end
end