class Graph < ActiveRecord::Base
  has_many :graph_items
  has_many :data_sources, :through => :graph_items

  accepts_nested_attributes_for :graph_items, :allow_destroy => true
  
end
