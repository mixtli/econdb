class CreateStocks < ActiveRecord::Migration
  def self.up
    create_table :stocks do |t|
      t.string :symbol
      t.string :name
      t.string :description
      t.references :exchange

      t.timestamps
    end
    add_index :stocks, :symbol
    add_index :stocks, :exchange_id
  end

  def self.down
    drop_table :stocks
  end
end
