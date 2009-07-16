class DataSource::YahooCurrency < DataSource
  #unloadable
  FULL_NAME = "Yahoo Currency"

  def self.data_source_arguments
    [:symbol]
  end
  
  def values(options = {})
    options[:start] ||= 1.year.ago.to_date
    options[:end] ||= Date.today
 
    options[:start] = options[:start].to_date
    options[:end] = options[:end].to_date

    vals = []
    (options[:start]..options[:end]).to_a.each do |date|
      datestr = date.strftime("%Y%m%d")
      my_uri = "http://finance.yahoo.com/webservice/v1/symbols/#{arguments[:symbol]}=X/quote;currency=true;date=#{datestr}"
      doc = REXML::Document.new(open(my_uri))
      data = self.class.parse_xml(doc)
      vals << data.collect {|d| { :x_value => d[:date], :y_value => d[:price] } }
    end
    vals.flatten!
    vals.sort_by {|v| v[:x_value] }
  end
        
  def self.populate_all_historical(start_date, end_date = Date.today)
    (start_date..end_date).to_a.each do |date|
      datestr = date.strftime("%Y%m%d")
      uri = "http://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote;currency=true;date=#{datestr}"
      doc = REXML::Document.new(open(uri))
      data = parse_xml(doc)
      data.each do |d|
        puts "adding #{d.inspect}"
        currency = Currency.find_by_code(d[:symbol])
        
        if currency
          begin 
            Datum.create(:data_source_id => currency.data_source.id, :timestamp => d[:date], :value => d[:price])
          rescue ActiveRecord::StatementInvalid => e
            #skip duplicates
          end
        end
      end
    end   
  end

  private
  def self.parse_xml(doc)
    data = []
    doc.root.each_element("//resource") do |el| 
      cdate = Date.parse(el.elements["field[@name='date']"].text) rescue Date.today
      data << { :symbol => el.elements["field[@name='symbol']"].text.gsub("=X",""),
              :price => el.elements["field[@name='price']"].text,
              :date => cdate
      }
    end
    data
  end

end
