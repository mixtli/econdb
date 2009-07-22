class CreateDataSources < ActiveRecord::Migration
  def self.up
    create_table :data_sources do |t|
      t.references :template
      t.string :name
      t.string :type
      t.string :units
      t.string :country, :limit => 2
      t.string :identifier
      t.text :arguments
      t.text :description
      t.datetime :populated_at
      t.timestamps
    end

    add_index :data_sources, :country
    add_index :data_sources, :identifier
  end

  def self.down
    drop_table :data_sources
  end
end
