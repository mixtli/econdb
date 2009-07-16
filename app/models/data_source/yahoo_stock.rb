class DataSource::YahooStock < DataSource
  FULL_NAME = "Yahoo Finance"

  def self.data_source_arguments
    [:symbol]
  end
  
  def values(options = {})
    options[:start] ||= 1.year.ago
    options[:end] ||= Time.now
    vals = []
    ::YahooFinance::get_HistoricalQuotes( 'YHOO', options[:start], options[:end]) do |hq|
      vals << { :x_value => Date.parse(hq.date), :y_value => hq.close }
    end
    vals.reverse #they come in reverse chronological from yahoo
  end
end
