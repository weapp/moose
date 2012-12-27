class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_role
    user = current_user || User.new
    user.role
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied."
    redirect_to new_user_session_path
  end

end
