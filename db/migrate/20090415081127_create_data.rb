class CreateData < ActiveRecord::Migration
  def self.up
    create_table :data do |t|
      t.references :data_source, :null => false
      t.datetime :timestamp, :null => false
      t.float :value, :null => false
    end
    add_index(:data, [:data_source_id, :timestamp], :unique => true)

  end

  def self.down
    drop_table :data
  end


end
