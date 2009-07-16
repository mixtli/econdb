class DataSourcesController < ApplicationController
  unloadable
  resources_controller_for :data_sources
  before_filter :set_klass, :only => [:new, :edit, :data_source_arguments]
  before_filter :get_times
  response_for :show do |format|
    @start_time ||= 1.year.ago
    options = {:start => @start_time, :end => @end_time}

    format.png do
      response.headers['Content-Type'] = 'image/png'

      graph = Graph.new(:title => resource.name)
      graph.graph_items << GraphItem.new(:data_source_id => resource.id)
      send_data GraphRenderer::GnuPlot.new.render(graph, options), :type => 'image/png'
    end

  end

  def set_klass
    self.resource = params[:id] ? find_resource : new_resource
    logger.debug "resource = #{self.resource.inspect}"
    if params[:data_source] && params[:data_source][:type]
      @klass = eval "#{params[:data_source][:type]}"
    else 
      @klass = resource.class
    end
  end
  
  def new_resource
    ds_type = params[resource_name][:type] rescue nil
    logger.debug "ds_type = #{ds_type}"
    unless ds_type.blank?
      eval "::DataSource::#{ds_type}.new(params[resource_name])"
    else
      DataSource.new(params[resource_name])
    end
  end

  def data_source_arguments
    logger.debug "klass = #{@klass}"
    resource.arguments  ||= {}
    @klass.data_source_arguments.each do |arg|
      unless resource.arguments[arg]
        resource.arguments[arg] = nil
      end
    end

    render :partial => 'data_source_arguments'
  end


end
