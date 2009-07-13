class DataSource < ActiveRecord::Base
  FULL_NAME = "Generic Data Source"
  has_many :graph_items
  has_many :graphs, :through => :graph_items
  serialize :arguments
  validates_inclusion_of :country, :in => Carmen::country_codes

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
  
  #override in subclasses
  def options_for(attr)
  end


  def type_name
    FULL_NAME
  end
end
