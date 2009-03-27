# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  before_filter :init_site
  
protected

  def init_site
    if session[:user_id]
      User.current = User.find(session[:user_id]) rescue nil
    end
  end
  
  def require_user
    unless User.current?
      flash[:notice] = "You need to be logged in to do this."
      redirect_to new_session_url
    end
    true
  end

  def require_guest
    if User.current?
      redirect_to User.current
    end
    true
  end
  
end
