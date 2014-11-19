class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def require_admin_user
    authenticate_or_request_with_http_basic do |username, password|
      username == "admin" && password == "supersecret"
    end
  end
end
