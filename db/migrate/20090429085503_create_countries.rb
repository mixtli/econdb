class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :iso, :limit => 2
      t.string :name, :printable_name
      t.string :iso3, :limit => 3
      t.string :currency_code
      t.integer :numcode
    end
  end

  def self.down
    drop_table :countries
  end
end
