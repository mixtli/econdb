class GraphItem < ActiveRecord::Base
  belongs_to :graph
  belongs_to :data_source
  accepts_nested_attributes_for :data_source
  after_destroy :delete_graph

  def delete_graph
    unless self.graph.graph_items
      self.graph.destroy
    end
  end
end

