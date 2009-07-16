require File.dirname(__FILE__) + "/../models/graph"
class GraphsController < ApplicationController
  #caches_page :show
  resources_controller_for :graphs
  before_filter :get_times

  response_for :show do |format|                                                              
    @start_time ||= Chronic.parse(resource.default_start_time)                                
    options = {:start => @start_time, :end => @end_time}                                      
    format.json do                                                                            
      render :text => GraphRenderer::OpenFlash.new.render(resource, options)                  
    end                                                                                       
    format.xml do
      render :xml => GraphRenderer::Flex.new.render(resource, options).to_xml
    end
    format.png do
      response.headers['Content-Type'] = 'image/png'
      #send_data GraphRenderer::Gruff.new.render(resource, options).to_blob, :type => 'image/png'
      send_data GraphRenderer::GnuPlot.new.render(resource, options), :type => 'image/png'
    end
    format.html
  end
  
end
