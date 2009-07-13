class CountriesController < ApplicationController
  def show
    @graphs = []
    DataSource.find(:all, :conditions => {:country => params[:id]}).each do |ds|
      ds.graphs.each do |g|
        @graphs << g
      end
    end
    @graphs.uniq!
  end
end
