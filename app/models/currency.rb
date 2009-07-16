class Currency < ActiveRecord::Base
  unloadable
  belongs_to :data_source
  after_create :create_data_source

  def create_data_source
    self.data_source = DataSource::YahooCurrency.create(:name => self.name, :arguments => {:symbol => self.code })
    self.save
  end

  def current_value
    self.data_source.data.last.value rescue nil
  end

end
