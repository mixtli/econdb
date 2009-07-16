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
  
  def get_times
    @start_time = case params[:start]
      when Hash
        DateTime.civil(params[:start][:year].to_i, params[:start][:month].to_i, params[:start][:day].to_i, params[:start][:hour].to_i, params[:start][:minute].to_i, 0)
      when String
        DateTime.strptime(params[:start], "%Y:%m:%d %h:%m:%s")
      else nil
    end
    @end_time = case params[:end]
      when Hash
        DateTime.civil(params[:end][:year].to_i, params[:end][:month].to_i, params[:end][:day].to_i, params[:end][:hour].to_i, params[:end][:minute].to_i, 0)
      when String
        DateTime.strptime(params[:end], "%Y:%m:%d %h:%m:%s")
      else DateTime.now
    end
    logger.debug "#{@start_time} to #{@end_time}"
  end


end
