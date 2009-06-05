class CreateFoobars < ActiveRecord::Migration
  def self.up
    create_table :foobars do |t|
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :foobars
  end
end
