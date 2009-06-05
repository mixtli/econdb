require File.dirname(__FILE__) + "/../models/graph"
class GraphsController < ApplicationController
  #caches_page :show
  resources_controller_for :graphs
  before_filter :get_times
  response_for :show do |format|
    options = {:start => @start_time, :end => @end_time}
    format.json do
      render :text => GraphRenderer::OpenFlash.new.render(resource, options)
    end
    format.xml do
      render :xml => GraphRenderer::Flex.new.render(resource, options).to_xml
    end
    format.png do
      response.headers['Content-Type'] = 'image/png'
      send_data GraphRenderer::Gruff.new.render(resource, options).to_blob, :type => 'image/png'
    end
    format.html
  end
  

  private
  
  def get_times
    @start_time = case params[:start]
      when Hash
        DateTime.civil(params[:start][:year].to_i, params[:start][:month].to_i, params[:start][:day].to_i, params[:start][:hour].to_i, params[:start][:minute].to_i, 0)
      when String
        DateTime.strptime(params[:start], "%Y:%m:%d %h:%m:%s")
      else 1.year.ago
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
