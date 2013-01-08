class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_role
    user = current_user || User.new
    user.auth
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied."
    redirect_to new_user_session_path
  end


  #def after_sign_in_path_for(resource)
  #  request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  #end

=begin
  def after_sign_in_path_for(resource)                                                                                                                      
    sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => 'http')                                            
    if request.referer == sign_in_url                                                                                                                    
      super                                                                                                                                                 
    else                                                                                                                                                    
      stored_location_for(resource) || "/home" || request.referer || root_path                                                                                         
    end                                                                                                                                                     
  end   
=end


end
