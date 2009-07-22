class DataSourceTemplate < ActiveRecord::Base
  has_many :data_sources, :foreign_key => 'template_id'

  def data_source_class
    logger.debug "data_source_type = #{data_source_type}"
    eval data_source_type
  end


  def create_data_source(args = {})
    args[:name] ||= self.name
    args[:identifier] ||= self.identifier
    type = args[:type] || self.data_source_type
    klass = eval type
    args[:units] ||= self.units
    self.data_sources << klass.create(args)

  end


  def populate_all!
    self.data_sources.each do |ds|
      ds.populate!
    end
  end
end
