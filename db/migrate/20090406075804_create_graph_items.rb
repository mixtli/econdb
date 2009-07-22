class CreateGraphItems < ActiveRecord::Migration
  def self.up
    create_table :graph_items do |t|
      t.string :title
      t.references :graph
      t.references :data_source
      t.string :color, :default => '#0f0'
      t.string :cdef
      t.timestamps
    end
    add_index :graph_items, :data_source_id
    add_index :graph_items, :graph_id
  end

  def self.down
    drop_table :graph_items
  end
end
