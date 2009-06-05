class MapsController < ApplicationController
  resources_controller_for :maps
  response_for :show do |format|
    format.html
    format.xml
  end


end
