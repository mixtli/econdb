class CreateGraphs < ActiveRecord::Migration
  def self.up
    create_table :graphs do |t|
      t.string :title
      t.string :units
      t.string :vertical_label
      t.string :horizontal_label

      t.timestamps
    end
  end

  def self.down
    drop_table :graphs
  end
end
