class CreateCurrencies < ActiveRecord::Migration
  def self.up
    create_table :currencies do |t|
      t.string :name
      t.string :code
      t.references :data_source
      t.timestamps
    end
  end

  def self.down
    drop_table :currencies
  end
end
