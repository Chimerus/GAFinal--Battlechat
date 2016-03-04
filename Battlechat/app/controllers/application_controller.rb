class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  ActionCable.server.config.allowed_request_origins = ['http://104.131.48.188']

  def authorize
    redirect_to '/login' unless current_user
  end

  protected

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end

  def logged_in?
    cookies[:auth_token].present?
  end

  helper_method :current_user, :logged_in?
end
