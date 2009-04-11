class DataSourcesController < ApplicationController
  resources_controller_for :data_sources
  
  def new_resource
    ds_type = params[resource_name][:type] rescue nil
    if ds_type
      eval "DataSource::#{ds_type}.new(params[resource_name])"
    else
      DataSource.new(params[resource_name])
    end
  end


end
