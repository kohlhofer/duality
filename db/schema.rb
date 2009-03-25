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

ActiveRecord::Schema.define(:version => 20090325180159) do

  create_table "choices", :force => true do |t|
    t.integer  "user_id"
    t.integer  "pair_id"
    t.integer  "item"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "choices", ["user_id", "pair_id"], :name => "index_choices_on_user_id_and_pair_id"

  create_table "pairs", :force => true do |t|
    t.integer  "creator_id"
    t.string   "item_1"
    t.string   "item_2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pairs", ["creator_id"], :name => "index_pairs_on_creator_id"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
