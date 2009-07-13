class DataSource::Xml < DataSource
  def self.data_source_arguments
    [:uri, :x_field_xpath, :y_field_xpath]
  end
  
  def values(options = {})
    # TODO: Grab xml from url, parse out values using user supplied xpaths
    []
  end
end
