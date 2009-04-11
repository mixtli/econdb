class DataSource < ActiveRecord::Base
  has_many :graph_items
  # override in subclasses
  def ds_type=(dstype)
    self.type = "DataSource::#{dstype}"
  end
  
  def values
    []
  end
  
end
