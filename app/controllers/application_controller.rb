class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ActionView::MissingTemplate, :with => :render_404
  
rescue_from ActionController::RoutingError,       :with => :render_404
rescue_from ActionController::UnknownController,  :with => :render_404
rescue_from ActionController::UnknownAction,      :with => :render_404


  force_ssl

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
