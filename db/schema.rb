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

ActiveRecord::Schema.define(:version => 20090819032328) do

  create_table "comments", :force => true do |t|
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "languages", :force => true do |t|
    t.string   "name",         :limit => 50, :default => "", :null => false
    t.string   "slug",         :limit => 20, :default => "", :null => false
    t.string   "description"
    t.integer  "pastes_count",               :default => 0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "languages", ["pastes_count"], :name => "index_languages_on_pastes_count"
  add_index "languages", ["slug"], :name => "index_languages_on_slug"

  create_table "pastes", :force => true do |t|
    t.string   "title",             :limit => 80
    t.text     "code",                                               :null => false
    t.text     "code_formatted",                                     :null => false
    t.text     "summary_formatted",                                  :null => false
    t.text     "desc"
    t.float    "size",                            :default => 0.0
    t.integer  "line_count",                      :default => 0,     :null => false
    t.integer  "comments_count",                  :default => 0,     :null => false
    t.integer  "views_count",                     :default => 0,     :null => false
    t.boolean  "private",                         :default => false, :null => false
    t.integer  "language_id",                                        :null => false
    t.integer  "user_id",                                            :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pastes", ["language_id"], :name => "index_pastes_on_language_id"
  add_index "pastes", ["private"], :name => "index_pastes_on_private"
  add_index "pastes", ["user_id"], :name => "index_pastes_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type",   :limit => 48
    t.string   "taggable_type", :limit => 48
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name", :limit => 48
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"

  create_table "users", :force => true do |t|
    t.string   "login",             :limit => 80
    t.string   "crypted_password"
    t.string   "persistence_token",                :default => "", :null => false
    t.string   "oauth_token",       :limit => 128
    t.string   "oauth_secret",      :limit => 128
    t.string   "twitter_uid",       :limit => 80
    t.string   "avatar_url"
    t.string   "name",              :limit => 80
    t.integer  "login_count",                      :default => 0,  :null => false
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.integer  "pastes_count",                     :default => 0,  :null => false
    t.integer  "comments_count",                   :default => 0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["oauth_token"], :name => "index_users_on_oauth_token"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
