class DataSource::Xml < DataSource
  def self.data_source_attributes
    [:url, :element_name, :x_field, :y_field]
  end
  
  def values(options = {})
    # TODO: Grab xml from url, parse, return values
    vals = []
  end
end
