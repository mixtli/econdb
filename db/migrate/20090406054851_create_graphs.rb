class CreateGraphs < ActiveRecord::Migration
  def self.up
    create_table :graphs do |t|
      t.string :title
      t.references :category
      t.string :units
      t.string :x_label, :y_label
      t.string :x_field, :y_field
      t.string :x_axis_type, :default => 'Linear'
      t.string :y_axis_type, :default => 'Linear'
      t.integer :minimum_value, :maximum_value      
      t.string :color, :default => '#0f0'
      t.string :background_color, :default => '#fff'
      t.string :default_start_time, :default => '1 year ago'      
      t.string :chart_type, :defauilt => 'Line'
      t.string :cached_tag_list
      t.userstamps
      t.timestamps
    end
    add_index :graphs, :category_id
  end

  def self.down
    drop_table :graphs
  end
end
