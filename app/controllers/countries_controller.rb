class CountriesController < ApplicationController
  resources_controller_for :countries

  def find_resource(id = params[:id])
    self.resource = Country.find_by_iso(id)
  end

  def show
    find_resource
    @graphs = []
    DataSource.find_all_by_country(params[:id]).each do |ds|
      ds.graphs.each do |g|
        @graphs << g
      end
    end
    @graphs.uniq!
  end


end
