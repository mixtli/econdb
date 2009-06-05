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

ActiveRecord::Schema.define(:version => 20090429085503) do

  create_table "countries", :force => true do |t|
    t.string  "iso",            :limit => 2
    t.string  "name"
    t.string  "printable_name"
    t.string  "iso3",           :limit => 3
    t.integer "numcode"
  end

  create_table "data", :force => true do |t|
    t.integer  "data_source_id"
    t.datetime "timestamp"
    t.string   "category"
    t.float    "value"
  end

  create_table "data_sources", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.string   "units"
    t.text     "arguments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "graph_items", :force => true do |t|
    t.string   "title"
    t.integer  "graph_id"
    t.integer  "data_source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color"
  end

  create_table "graphs", :force => true do |t|
    t.string   "title"
    t.string   "units"
    t.string   "x_label"
    t.string   "y_label"
    t.string   "x_field"
    t.string   "y_field"
    t.string   "chart_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "x_axis_type"
    t.string   "y_axis_type"
    t.string   "color"
    t.string   "background_color"
  end

  create_table "maps", :force => true do |t|
    t.string   "title"
    t.string   "filename"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name",              :limit => 40
    t.string   "authorizable_type", :limit => 40
    t.integer  "authorizable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
