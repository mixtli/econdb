# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery  # See ActionController::RequestForgeryProtection for details
  include AuthenticatedSystem
  include Userstamp  
  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  # Turn off layout for AJAX requests
  layout proc{ |c| c.request.xhr? ? false : "application" }


  #def current_category
  #  return Category.find(session[:category_id])
  #end
end
