class DataSource < ActiveRecord::Base

  #unloadable
  FULL_NAME = "Generic Data Source"
  belongs_to :data_source_template, :foreign_key => 'template_id'
  has_many :graph_items, :dependent => :destroy
  has_many :graphs, :through => :graph_items
  has_many :data, :dependent => :destroy
  serialize :arguments
  after_create :create_graph
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
      next if ds.class == DataSource::YahooCurrency  # skip this.. it's slow..  use populate_all_historical
      ds.populate!
    end
  end

  def populate!(start_time = DateTime.parse("1900-01-01"), end_time = DateTime.now)
    last_update = self.data.maximum(:timestamp)
    if last_update && last_update > start_time
      start_time = last_update
    end

    self.load_data(start_time, end_time).each do |datum|
      begin
        self.data << datum
      rescue ActiveRecord::StatementInvalid => e 
        # skip duplicate record
      end
    end
    self.populated_at = DateTime.now
    save!
  end

  def load_data(start_time, end_time)
    puts "load_data"
    values(:start => start_time, :end => end_time).collect {|v| Datum.new(:timestamp => v[:x_value], :value => v[:y_value]) }
  end


  # override in subclasses
  def self.identifier_options
  end

  def create_graph
    graph = Graph.create(:title => self.name)
    graph.graph_items << GraphItem.create(:title => self.name, :data_source => self)

  end

  def country_name
    return nil unless country
    Country.find_by_iso(country).name
  end

end
