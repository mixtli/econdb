class Graph < ActiveRecord::Base
  stampable
  has_many :graph_items
  has_many :data_sources, :through => :graph_items
  belongs_to :category
  belongs_to :creator, :class_name => 'User'
  belongs_to :updater, :class_name => 'User'
  accepts_nested_attributes_for :graph_items, :allow_destroy => true
  acts_as_taggable
end
