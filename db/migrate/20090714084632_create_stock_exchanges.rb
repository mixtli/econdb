class CreateStockExchanges < ActiveRecord::Migration
  def self.up
    create_table :stock_exchanges do |t|
      t.string :name
      t.string :symbol
      t.string :description
      t.string :country
      t.references :data_source
      t.timestamps
    end
    add_index :stock_exchanges, :symbol
  end

  def self.down
    drop_table :stock_exchanges
  end
end
