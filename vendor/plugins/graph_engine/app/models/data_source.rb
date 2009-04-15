class DataSource < ActiveRecord::Base
  has_many :graph_items
  serialize :arguments

  def self.data_source_arguments
    []
  end
  # override in subclasses
  def ds_type=(dstype)
    self.type = "DataSource::#{dstype}"
  end
  
  def values
    []
  end
  
end
