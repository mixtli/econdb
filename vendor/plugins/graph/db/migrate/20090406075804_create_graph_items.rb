class CreateGraphItems < ActiveRecord::Migration
  def self.up
    create_table :graph_items do |t|
      t.string :title
      t.references :graph
      t.references :data_source
      t.string :color, :default => '#0f0'
      t.timestamps
    end
  end

  def self.down
    drop_table :graph_items
  end
end
