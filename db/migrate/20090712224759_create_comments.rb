class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :title, :limit => 50, :default => ''
      t.text :body, :default => ''
      t.references :commentable, :polymorphic => true
      t.userstamps
      t.timestamps
    end
    add_index :comments, [:commentable_id, :commentable_type]
  end

  def self.down
    drop_table :comments
  end
end
