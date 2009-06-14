class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.references :parent
      t.integer :position
      t.integer :children_count
      t.integer :ancestors_count
      t.integer :descendants_count
      t.boolean :hidden
      t.string :name
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
