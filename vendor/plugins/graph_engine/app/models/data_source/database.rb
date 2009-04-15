class DataSource::Database < DataSource
  def self.data_source_arguments
    [:table, :x_column, :y_column]
  end
  def values(options = {})
    vals = []
    ActiveRecord::Base.connection.select_all("SELECT #{arguments[:x_column]}, #{arguments[:y_column]} FROM #{arguments[:table]}").each do |record|
      vals << {:x_field => record[arguments[:x_column]], :y_field => record[arguments[:y_column]] }
    end
    vals
  end
end
