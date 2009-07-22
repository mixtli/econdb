class DataSourceTemplatesController < ApplicationController
  #unloadable
  resources_controller_for :data_source_templates
  before_filter :set_klass, :only => [:new, :edit, :data_source_arguments]

  public
  def data_source_arguments
    logger.debug "klass = #{@klass}"
    render :partial => 'data_source_arguments'
  end

  def create_all
    self.resource = find_resource
    Country.all.each do |c|
      resource.create_data_source(:country => c.iso, :name => "#{c.name} #{resource.name}")
    end
    flash[:notice] = "Created DataSources from Template"
    redirect_to :back
  end


  private
  def set_klass
    self.resource = params[:id] ? find_resource : new_resource
    logger.debug "resource = #{self.resource.inspect}"
    if params[:data_source_template] && params[:data_source_template][:data_source_type]
      @klass = eval "#{params[:data_source_template][:data_source_type]}"
    else 
      @klass = resource.class
    end
  end
  
 

end
