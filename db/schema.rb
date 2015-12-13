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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150927175249) do

  create_table "movie_tags", force: true do |t|
    t.integer "movie_id"
    t.integer "tag_id"
    t.decimal "relevance"
  end

  add_index "movie_tags", ["movie_id"], name: "index_movie_tags_on_movie_id"
  add_index "movie_tags", ["tag_id"], name: "index_movie_tags_on_tag_id"

  create_table "movies", force: true do |t|
    t.integer  "movie_id"
    t.string   "title"
    t.integer  "movie_popularity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "year"
  end

  add_index "movies", ["movie_id"], name: "index_movies_on_movie_id", unique: true

  create_table "tags", force: true do |t|
    t.integer  "tag_id"
    t.string   "name"
    t.integer  "tag_popularity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["tag_id"], name: "index_tags_on_tag_id", unique: true

end
