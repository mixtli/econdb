class DataSource::FederalReserve < DataSource
  FULL_NAME = "U.S. Federal Reserve"


  def values(options = {})
    logger.debug "DataSource::FederalReserve.values"
    options[:start] ||= 1.year.ago
    options[:end] ||= Time.now
    series = ::Fred::Series.get(arguments[:fred_id])
    fred_params = {}
    fred_params[:observation_start] = options[:start].strftime("%Y-%m-%d")
    fred_params[:observation_end] = options[:end].strftime("%Y-%m-%d")
    series.observations(fred_params).map {|obs| {:x_value => obs[:date], :y_value => obs[:value].to_i}}
  end


end
