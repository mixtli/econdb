class DataSourcesController < ApplicationController
  resources_controller_for :data_sources
  
  def new_resource
    ds_type = params[resource_name][:type] rescue nil
    logger.debug "ds_type = #{ds_type}"
    unless ds_type.blank?
      eval "DataSource::#{ds_type}.new(params[resource_name])"
    else
      DataSource.new(params[resource_name])
    end
  end

  def data_source_arguments
    self.resource = params[:id] ? find_resource : new_resource
    logger.debug "resource = #{self.resource.inspect}"
    resource.arguments  ||= {}
    resource.class.data_source_arguments.each do |arg|
      if params[arg]
        resource.arguments[arg] = params[arg]
      else
        resource.arguments[arg] = nil
      end
    end

    render :partial => 'data_source_arguments'
  end


end
