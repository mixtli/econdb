class CreateData < ActiveRecord::Migration
  def self.up
    create_table :data do |t|
      t.references :data_source
      t.datetime :timestamp
      t.float :value
    end
    add_index(:data, [:data_source_id, :timestamp], :unique => true)

  end

  def self.down
    drop_table :data
  end


end
