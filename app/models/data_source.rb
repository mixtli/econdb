class DataSource < ActiveRecord::Base
  unloadable
  FULL_NAME = "Generic Data Source"
  has_many :graph_items
  has_many :graphs, :through => :graph_items
  has_many :data
  serialize :arguments
  validates_inclusion_of :country, :in => Carmen::country_codes

  def self.data_source_arguments
    []
  end
  # override in subclasses
  def ds_type=(dstype)
    self.type = "DataSource::#{dstype}"
  end
  
  def values
    []
  end
  
  #override in subclasses
  def options_for(attr)
  end


  def type_name
    self.class::FULL_NAME
  end


  def self.populate!
    DataSource.find(:all).each do |ds|
      ds.populate!
    end
  end

  def populate!(start_time = DateTime.parse("1900-01-01"), end_time = DateTime.now)
    last_update = self.data.maximum(:timestamp)
    if last_update && last_update > start_time
      start_time = last_update
    end

    self.load_data(start_time, end_time).each do |datum|
     puts "doing datum #{datum}"
      begin
        self.data << datum
      rescue ActiveRecord::StatementInvalid => e 
        # skip duplicate record
      end
    end
  end

  def load_data(start_time, end_time)
    puts "load_data"
    values(:start => start_time, :end => end_time).collect {|v| Datum.new(:timestamp => v[:x_value], :value => v[:y_value]) }
  end


end
