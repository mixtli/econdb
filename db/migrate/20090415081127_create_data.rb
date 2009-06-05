class CreateData < ActiveRecord::Migration
  def self.up
    create_table :data do |t|
      t.references :data_source
      t.datetime :timestamp
      t.string :category
      t.float :value
    end
  end

  def self.down
    drop_table :data
  end
end
