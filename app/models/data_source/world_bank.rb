class DataSource::WorldBank < DataSource
  def self.data_source_arguments
    [:indicator]
  end
  
  def values(options = {})
    options[:start] ||= 1.year.ago
    options[:end] ||= Time.now
    indicator = ::WorldBank::Indicator.get(arguments[:indicator])
    wb_params = {}
    wb_params[:date] = options[:start].strftime("%Y") + ":" + options[:end].strftime("%Y")
    indicator.data(wb_params).map {|obs| {:x_value => DateTime.parse(obs['date']), :y_value => obs['value'].to_i}}
  end
end
