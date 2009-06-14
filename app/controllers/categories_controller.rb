class CategoriesController < ApplicationController
  resources_controller_for :categories
  def update_positions
    Category.update_positions(params)
    render :nothing => true
  end

  def edit_positions

  end

end
