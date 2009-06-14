class AddCachedTagListToGraphs < ActiveRecord::Migration
  def self.up
    add_column :graphs, :cached_tag_list, :string
  end

  def self.down
    remove_column :graphs, :cached_tag_list
  end
end
