class DataSource::ActiveRecord < DataSource
  def self.data_source_arguments
    [:class_name, :x_field, :y_field]
  end
  
  def render(options = {}) 
    vals = []
    klass = eval "#{arguments[:class_name]}"
    klass.find(:all).each do |row|
      vals << {:x_field => row.send(arguments[:x_field].to_sym), :y_field => row.send(arguments[:y_field].to_sym)}
    end
    vals
  end
end
