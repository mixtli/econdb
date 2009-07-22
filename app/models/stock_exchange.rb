class StockExchange < ActiveRecord::Base
  belongs_to :data_source
end
