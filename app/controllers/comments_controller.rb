class CommentsController < ApplicationController
  resources_controller_for :comments

  response_for :create do |format|
    format.html do
      flash[:notice] = "Comment Added"
      redirect_to :back 
    end
  end

end
