class GraphItem < ActiveRecord::Base
  belongs_to :graph
  belongs_to :data_source
  accepts_nested_attributes_for :data_source
end
