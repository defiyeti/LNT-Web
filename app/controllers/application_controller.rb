class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #acts_as_token_authentication_handler_for User

  before_filter :add_csrf_token

  def add_csrf_token
  	response.headers['X-Csrf-Token'] = form_authenticity_token
  	if current_user
  		response.headers['X-Auth-Token'] = current_user.authentication_token
	end
  end
end
