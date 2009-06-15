class DataSource::Rrd < DataSource
  def self.data_source_arguments
    [:filename ]
  end
  def values(options = {})
    vals = []
    (fstart, fend, data, step) = RRD.fetch(arguments[:filename], "--start", options[:start].to_i.to_s, "--end", (options[:start].to_i + 300 * 300).to_s, "AVERAGE")
    curr_time = fstart
    data.each do |datum|
      vals << {:x_field => curr_time, :y_field => datum }
      curr_time += step.seconds
    end
    vals
  end
end
