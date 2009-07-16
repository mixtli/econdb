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

ActiveRecord::Schema.define(:version => 20090714090118) do

  create_table "categories", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "position"
    t.integer  "children_count"
    t.integer  "ancestors_count"
    t.integer  "descendants_count"
    t.boolean  "hidden"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string  "iso",            :limit => 2
    t.string  "name"
    t.string  "printable_name"
    t.string  "iso3",           :limit => 3
    t.string  "currency_code"
    t.integer "numcode"
  end

  create_table "currencies", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currency_historical_rates", :force => true do |t|
    t.datetime "created_on",                 :null => false
    t.datetime "updated_on"
    t.string   "c1",           :limit => 3,  :null => false
    t.string   "c2",           :limit => 3,  :null => false
    t.string   "source",       :limit => 32, :null => false
    t.float    "rate",                       :null => false
    t.float    "rate_avg"
    t.integer  "rate_samples"
    t.float    "rate_lo"
    t.float    "rate_hi"
    t.float    "rate_date_0"
    t.float    "rate_date_1"
    t.datetime "date",                       :null => false
    t.datetime "date_0"
    t.datetime "date_1"
    t.string   "derived",      :limit => 64
  end

  add_index "currency_historical_rates", ["c1", "c2", "source", "date_0", "date_1"], :name => "c1_c2_src_date_range", :unique => true
  add_index "currency_historical_rates", ["c1"], :name => "index_currency_historical_rates_on_c1"
  add_index "currency_historical_rates", ["c2"], :name => "index_currency_historical_rates_on_c2"
  add_index "currency_historical_rates", ["date"], :name => "index_currency_historical_rates_on_date"
  add_index "currency_historical_rates", ["date_0"], :name => "index_currency_historical_rates_on_date_0"
  add_index "currency_historical_rates", ["date_1"], :name => "index_currency_historical_rates_on_date_1"
  add_index "currency_historical_rates", ["source"], :name => "index_currency_historical_rates_on_source"

  create_table "data", :force => true do |t|
    t.integer  "data_source_id"
    t.datetime "timestamp"
    t.float    "value"
  end

  add_index "data", ["data_source_id", "timestamp"], :name => "index_data_on_data_source_id_and_timestamp", :unique => true

  create_table "data_sources", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.string   "units"
    t.string   "country",    :limit => 2
    t.text     "arguments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "graph_items", :force => true do |t|
    t.string   "title"
    t.integer  "graph_id"
    t.integer  "data_source_id"
    t.string   "color",          :default => "#0f0"
    t.string   "cdef"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "graphs", :force => true do |t|
    t.string   "title"
    t.string   "units"
    t.string   "x_label"
    t.string   "y_label"
    t.string   "x_field"
    t.string   "y_field"
    t.string   "x_axis_type",        :default => "Linear"
    t.string   "y_axis_type",        :default => "Linear"
    t.integer  "minimum_value"
    t.integer  "maximum_value"
    t.string   "color",              :default => "#0f0"
    t.string   "background_color",   :default => "#fff"
    t.string   "default_start_time", :default => "1 year ago"
    t.string   "chart_type"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cached_tag_list"
    t.integer  "category_id"
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

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "stock_exchanges", :force => true do |t|
    t.string   "name"
    t.string   "symbol"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stock_quotes", :force => true do |t|
    t.integer  "stock_id"
    t.datetime "quote_time"
    t.float    "open"
    t.float    "close"
    t.float    "high"
    t.float    "low"
    t.float    "volume"
    t.float    "adj_close"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stocks", :force => true do |t|
    t.string   "symbol"
    t.string   "name"
    t.string   "description"
    t.integer  "exchange_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
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
