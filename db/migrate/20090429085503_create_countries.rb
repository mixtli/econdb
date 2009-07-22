class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :iso, :limit => 2
      t.string :name, :printable_name
      t.string :iso3, :limit => 3
      t.string :currency_code
      t.integer :numcode
      t.references :map
    end
    
    add_index :countries, :iso
    add_index :countries, :iso3
    add_index :countries, :currency_code
    add_index :countries, :numcode

  end

  def self.down
    drop_table :countries
  end
end
