class CreateCurrencies < ActiveRecord::Migration
  def self.up
    create_table :currencies do |t|
      t.string :name
      t.string :code
      t.references :data_source
      t.timestamps
    end
    add_index :currencies, :code
    add_index :currencies, :data_source
  end

  def self.down
    drop_table :currencies
  end
end
