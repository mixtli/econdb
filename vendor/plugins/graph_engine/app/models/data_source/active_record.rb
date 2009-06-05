# Assumes your table has a timestamp field
class DataSource::ActiveRecord < DataSource
  def self.data_source_arguments
    [:class_name, :x_field, :y_field]
  end
  
  def render(options = {}) 
    options[:start] ||= 1.year.ago
    options[:end] ||= Time.now
    vals = []
    klass = eval "#{arguments[:class_name]}"
    klass.find(:all, :conditions => ["timestamp >= ? AND timestamp <= ?", options[:start], options[:end]]).each do |row|
      vals << {:x_field => row.send(arguments[:x_field].to_sym), :y_field => row.send(arguments[:y_field].to_sym)}
    end
    vals
  end
end
