# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130109193431) do

  create_table "books", :force => true do |t|
    t.string "_id",          :null => false
    t.string "title"
    t.string "publisher"
    t.string "creator"
    t.text   "description"
    t.string "dplaLocation"
  end

  add_index "books", ["_id"], :name => "index_books_on_@id", :unique => true

  create_table "date_ranges", :force => true do |t|
    t.integer "book_id", :null => false
    t.string  "start"
    t.string  "end"
  end

  add_index "date_ranges", ["book_id"], :name => "index_date_ranges_on_book_id"

  create_table "users", :force => true do |t|
    t.string "email"
    t.string "password_digest"
    t.string "token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["token"], :name => "index_users_on_token"

end
