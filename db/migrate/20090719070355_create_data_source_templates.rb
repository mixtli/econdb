class CreateDataSourceTemplates < ActiveRecord::Migration
  def self.up
    create_table :data_source_templates do |t|
      t.string :name
      t.string :data_source_type
      t.string :units
      t.string :identifier
      t.timestamps
    end
    add_index :data_source_templates, [:data_source_type, :identifier], :unique => true
  end

  def self.down
    drop_table :data_source_templates
  end
end
