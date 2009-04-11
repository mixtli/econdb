# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090406075804) do

  create_table "data_sources", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.string   "units"
    t.string   "fred_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "graph_items", :force => true do |t|
    t.string   "title"
    t.integer  "graph_id"
    t.integer  "data_source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "graphs", :force => true do |t|
    t.string   "title"
    t.string   "units"
    t.string   "vertical_label"
    t.string   "horizontal_label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
