class TagsController < ApplicationController

  def index
    @tags = Tag.counts
  end

  def show
    @graphs = Graph.find_tagged_with(params[:id].gsub("+"," "))
  end
end
