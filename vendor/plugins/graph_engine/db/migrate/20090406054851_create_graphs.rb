class CreateGraphs < ActiveRecord::Migration
  def self.up
    create_table :graphs do |t|
      t.string :title
      t.string :units
      t.string :x_label, :y_label
      t.string :x_field, :y_field
      t.string :x_axis_type, :default => 'Linear'
      t.string :y_axis_type, :default => 'Linear'
      
      t.string :color, :default => '#0f0'
      t.string :background_color, :default => '#fff'
      
      t.string :chart_type
      t.timestamps
    end
  end

  def self.down
    drop_table :graphs
  end
end
