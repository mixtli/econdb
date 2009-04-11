class DataSource::FederalReserve < DataSource
  def values(options = {})
    logger.debug "fred_id = #{fred_id}"
    series = ::Fred::Series.get(fred_id)
    params = {}
    params[:observation_start] = 1.year.ago.strftime("%Y-%m-%d")
    series.observations(params).map {|obs| [obs['date'], obs['value']]}
  end
end