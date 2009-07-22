class MapsController < ApplicationController
  resources_controller_for :maps
  response_for :show do |format|
    format.html
    format.xml
  end
  map_enclosing_resource :country do
    Country.find_by_iso(params[:country_id])
  end

  def find_resource
    if enclosing_resource
      enclosing_resource.map
    else
      Map.find(params[:id])
    end
  end  

  def show
    @map = find_resource
    
    @countries = {}
    DataSource.find_all_by_identifier(params[:indicator]).each do |ds|
      next unless ds.country && ds.data.last && ds.data.last.value
      @countries[ds.country] = {:value => (ds.data.last.value rescue nil) }
    end
    
  end

end
