class GraphsController < ApplicationController
  resources_controller_for :graphs
  
  caches_action :show, :expires_in => 1.day.to_i
  response_for :show do |format|
    format.png do
      send_data create_graph.to_blob, :type => 'image/png'
    end
  end

  def new_resource
    returning resource_service.new(params[resource_name]) do |r|
        gi = r.graph_items.build
        gi.build_data_source
    end 
  end
  
  def find_resource(id=params[:id])
    returning resource_service.find(id) do |r|
      if r.graph_items.empty?
        gi = r.graph_items.build
        gi.data_source = DataSource.new
      end
    end 
  end
  
  def create_graph
    create_gruff_graph
  end
  
  def create_gruff_graph
    returning Gruff::Line.new do |g|
      g.title = resource.title
      g.x_axis_label = resource.horizontal_label
      g.y_axis_label = resource.vertical_label
      resource.graph_items.each do |item|
        logger.debug "data = " + item.data_source.values.inspect
        g.data(item.data_source.name, item.data_source.values.collect {|v| v[1].to_f})
        labels = {}
        num_labels = 5
        num_items = item.data_source.values.size
        per_label = num_items/num_labels
        item.data_source.values.each_with_index do |v, idx|
          labels[idx] = v[0] if idx % per_label == 0
        end
        g.labels = labels
      end
    end
  end
  
end
