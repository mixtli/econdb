class DataSource::WorldBank < DataSource
  FULL_NAME = "World Bank"
  def self.data_source_arguments
    [:indicator]
  end
  
  def values(options = {})
    options[:start] ||= 1.year.ago
    options[:end] ||= Time.now
    indicator = ::WorldBank::Indicator.get(arguments[:indicator])
    wb_params = {}
    wb_params[:date] = options[:start].strftime("%Y") + ":" + options[:end].strftime("%Y")
    data = indicator.data(country, wb_params).map {|obs| {:x_value => obs[:date], :y_value => obs[:value].to_i}}
    # For some reason WB data often has a meaningless 0 last value if not populated instead of just omitting it
    if !data.empty? && data.last[:y_value] == 0
      data.pop
    end
    data
  end

  def options_for(attr)
    logger.debug "options_for(#{attr})"
    case attr
      when :indicator then 
       ::WorldBank::Indicator.find.collect {|i| [i['name'], i['id']] }
      when :country then
       Carmen::COUNTRIES
    else
      nil
    end
  end
end
