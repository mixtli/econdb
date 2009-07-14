class CreateStockQuotes < ActiveRecord::Migration
  def self.up
    create_table :stock_quotes do |t|
      t.references :stock
      t.datetime :quote_time
      t.float :open
      t.float :close
      t.float :high
      t.float :low
      t.float :volume
      t.float :adj_close

      t.timestamps
    end
  end

  def self.down
    drop_table :stock_quotes
  end
end
