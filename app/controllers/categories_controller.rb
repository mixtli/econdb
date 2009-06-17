class CategoriesController < ApplicationController
  resources_controller_for :categories
  before_filter :set_category, :only => :show
  def update_positions
    Category.update_positions(params)
    render :nothing => true
  end

  def edit_positions

  end

  private
  def set_category
    session[:category_id] = params[:id]
  end

end
