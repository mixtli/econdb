class CreateDataSources < ActiveRecord::Migration
  def self.up
    create_table :data_sources do |t|
      t.string :name
      t.string :type
      t.string :units
      t.string :country, :limit => 2
      t.string :identifier
      t.text :arguments
      t.timestamps
    end
  end

  def self.down
    drop_table :data_sources
  end
end
