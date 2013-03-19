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

ActiveRecord::Schema.define(:version => 20130319214752) do

  create_table "books", :force => true do |t|
    t.string  "source_id",                  :null => false
    t.string  "title"
    t.string  "publisher"
    t.string  "creator"
    t.text    "description"
    t.string  "source_url"
    t.string  "viewer_url"
    t.string  "cover_small"
    t.string  "cover_large"
    t.integer "shelfrank"
    t.string  "subjects"
    t.integer "pub_date"
    t.integer "measurement_page_numeric"
    t.integer "measurement_height_numeric"
    t.string  "source_library"
  end

  add_index "books", ["shelfrank"], :name => "index_books_on_shelfrank"
  add_index "books", ["source_id"], :name => "index_books_on_@id", :unique => true
  add_index "books", ["subjects"], :name => "index_books_on_subjects"

  create_table "reviews", :force => true do |t|
    t.string  "book_id", :null => false
    t.integer "user_id", :null => false
    t.integer "rating"
    t.text    "comment"
  end

  add_index "reviews", ["book_id"], :name => "index_reviews_on_book_id"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "shelves", :force => true do |t|
    t.integer "user_id"
    t.string  "name"
    t.text    "description"
    t.text    "book_ids"
  end

  add_index "shelves", ["user_id"], :name => "index_shelves_on_user_id"

  create_table "users", :force => true do |t|
    t.string "email"
    t.string "password_digest"
    t.string "token"
    t.string "display_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["token"], :name => "index_users_on_token"

end
