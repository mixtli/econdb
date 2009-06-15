class AddCategoryToGraphs < ActiveRecord::Migration
  def self.up
    add_column :graphs, :category_id, :integer
  end

  def self.down
    remove_column :graphs, :category_id
  end
end
