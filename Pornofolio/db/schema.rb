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

ActiveRecord::Schema.define(version: 20140323104012) do

  create_table "access_logs", force: true do |t|
    t.integer  "user_id",        limit: 8,  null: false
    t.text     "user_agent"
    t.text     "referer"
    t.integer  "post_id",        limit: 8
    t.text     "access_url",                null: false
    t.string   "request_method", limit: 10, null: false
    t.string   "ip",             limit: 50, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "access_logs", ["created_at"], name: "index_access_logs_on_created_at", using: :btree
  add_index "access_logs", ["ip"], name: "index_access_logs_on_ip", using: :btree
  add_index "access_logs", ["post_id"], name: "index_access_logs_on_post_id", using: :btree
  add_index "access_logs", ["user_id"], name: "index_access_logs_on_user_id", using: :btree

  create_table "access_logs_ip_infos", id: false, force: true do |t|
    t.integer "access_log_id", limit: 8, null: false
    t.integer "ip_info_id",              null: false
  end

  add_index "access_logs_ip_infos", ["access_log_id"], name: "index_access_logs_ip_infos_on_access_log_id", using: :btree
  add_index "access_logs_ip_infos", ["ip_info_id"], name: "index_access_logs_ip_infos_on_ip_info_id", using: :btree

  create_table "ad_analyses", force: true do |t|
    t.integer  "ad_id",      limit: 2, null: false
    t.integer  "user_id",    limit: 8, null: false
    t.integer  "post_id",    limit: 8
    t.text     "view_url",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ad_analyses", ["ad_id", "post_id"], name: "index_ad_analyses_on_ad_id_and_post_id", using: :btree
  add_index "ad_analyses", ["ad_id", "user_id"], name: "index_ad_analyses_on_ad_id_and_user_id", using: :btree
  add_index "ad_analyses", ["ad_id"], name: "index_ad_analyses_on_ad_id", using: :btree

  create_table "ads", force: true do |t|
    t.text   "ad_object",             null: false
    t.string "company",   limit: 50,  null: false
    t.string "ad_type",   limit: 100, null: false
  end

  add_index "ads", ["ad_type"], name: "index_ads_on_ad_type", using: :btree
  add_index "ads", ["company", "ad_type"], name: "index_ads_on_company_and_ad_type", using: :btree
  add_index "ads", ["company"], name: "index_ads_on_company", using: :btree

  create_table "asgs", force: true do |t|
    t.string   "video_id",   limit: 30, null: false
    t.string   "title"
    t.string   "img_path",   limit: 60, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "asgs", ["img_path"], name: "index_asgs_on_img_path", unique: true, using: :btree
  add_index "asgs", ["video_id"], name: "index_asgs_on_video_id", unique: true, using: :btree

  create_table "asgs_post_content_details", id: false, force: true do |t|
    t.integer "asg_id",                 limit: 8, null: false
    t.integer "post_content_detail_id", limit: 8, null: false
  end

  add_index "asgs_post_content_details", ["asg_id"], name: "index_asgs_post_content_details_on_asg_id", using: :btree
  add_index "asgs_post_content_details", ["post_content_detail_id"], name: "index_asgs_post_content_details_on_post_content_detail_id", using: :btree

  create_table "beta", force: true do |t|
    t.integer  "user_id",    limit: 8,  null: false
    t.string   "beta_hash",  limit: 40, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "beta", ["beta_hash"], name: "index_beta_on_beta_hash", unique: true, using: :btree
  add_index "beta", ["user_id"], name: "index_beta_on_user_id", unique: true, using: :btree

  create_table "categories", force: true do |t|
    t.string "name", limit: 100, null: false
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "categories_posts", id: false, force: true do |t|
    t.integer "post_id",     limit: 8, null: false
    t.integer "category_id", limit: 8, null: false
  end

  add_index "categories_posts", ["category_id"], name: "index_categories_posts_on_category_id", using: :btree
  add_index "categories_posts", ["post_id"], name: "index_categories_posts_on_post_id", using: :btree

  create_table "ip_infos", force: true do |t|
    t.string   "ip",             limit: 50,  null: false
    t.string   "latitude",       limit: 15
    t.string   "longitude",      limit: 15
    t.string   "country_name",   limit: 100
    t.string   "country_code",   limit: 2
    t.string   "continent_code", limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ip_infos", ["ip", "country_name"], name: "index_ip_infos_on_ip_and_country_name", using: :btree
  add_index "ip_infos", ["ip", "latitude", "longitude"], name: "index_ip_infos_on_ip_and_latitude_and_longitude", using: :btree
  add_index "ip_infos", ["ip"], name: "index_ip_infos_on_ip", unique: true, using: :btree

  create_table "post_analyses", force: true do |t|
    t.integer  "post_id",               limit: 8, null: false
    t.integer  "post_analysis_type_id", limit: 2, null: false
    t.datetime "measured_at",                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_analyses", ["measured_at", "post_analysis_type_id"], name: "index_post_analyses_on_measured_at_and_post_analysis_type_id", using: :btree
  add_index "post_analyses", ["post_id", "post_analysis_type_id", "measured_at"], name: "post_analyses_index", using: :btree

  create_table "post_analysis_types", force: true do |t|
    t.string "name", limit: 100, null: false
  end

  add_index "post_analysis_types", ["name"], name: "index_post_analysis_types_on_name", unique: true, using: :btree

  create_table "post_comments", force: true do |t|
    t.integer  "post_id",    limit: 8, null: false
    t.integer  "user_id",    limit: 8, null: false
    t.text     "text",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_comments", ["post_id"], name: "index_post_comments_on_post_id", using: :btree
  add_index "post_comments", ["user_id"], name: "index_post_comments_on_user_id", using: :btree

  create_table "post_content_detail_types", force: true do |t|
    t.string "name", limit: 150, null: false
  end

  add_index "post_content_detail_types", ["name"], name: "index_post_content_detail_types_on_name", unique: true, using: :btree

  create_table "post_content_details", force: true do |t|
    t.integer  "post_content_id",             limit: 8,                 null: false
    t.text     "text",                                                  null: false
    t.boolean  "is_broken",                             default: false, null: false
    t.boolean  "is_request",                            default: false, null: false
    t.integer  "post_content_detail_type_id", limit: 2,                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_content_details", ["post_content_detail_type_id"], name: "index_post_content_details_on_post_content_detail_type_id", using: :btree
  add_index "post_content_details", ["post_content_id"], name: "index_post_content_details_on_post_content_id", using: :btree

  create_table "post_content_details_xvideos", id: false, force: true do |t|
    t.integer "post_content_detail_id", limit: 8, null: false
    t.integer "xvideos_id",                       null: false
  end

  add_index "post_content_details_xvideos", ["post_content_detail_id"], name: "index_post_content_details_xvideos_on_post_content_detail_id", using: :btree
  add_index "post_content_details_xvideos", ["xvideos_id"], name: "index_post_content_details_xvideos_on_xvideos_id", using: :btree

  create_table "post_content_types", force: true do |t|
    t.string "name", limit: 150, null: false
  end

  add_index "post_content_types", ["name"], name: "index_post_content_types_on_name", unique: true, using: :btree

  create_table "post_contents", force: true do |t|
    t.integer  "post_id",              limit: 8, null: false
    t.integer  "order",                          null: false
    t.integer  "post_content_type_id", limit: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_contents", ["post_content_type_id"], name: "index_post_contents_on_post_content_type_id", using: :btree
  add_index "post_contents", ["post_id", "post_content_type_id"], name: "index_post_contents_on_post_id_and_post_content_type_id", using: :btree
  add_index "post_contents", ["post_id"], name: "index_post_contents_on_post_id", using: :btree

  create_table "post_likes", force: true do |t|
    t.integer  "post_id",    limit: 8, null: false
    t.integer  "user_id",    limit: 8, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_likes", ["post_id"], name: "index_post_likes_on_post_id", using: :btree
  add_index "post_likes", ["user_id"], name: "index_post_likes_on_user_id", using: :btree

  create_table "post_types", force: true do |t|
    t.string "name", limit: 100, null: false
  end

  add_index "post_types", ["name"], name: "index_post_types_on_name", unique: true, using: :btree

  create_table "posts", force: true do |t|
    t.string   "title",                                   null: false
    t.integer  "user_id",       limit: 8,                 null: false
    t.text     "thumbnail"
    t.string   "description"
    t.integer  "post_type_id",  limit: 2,                 null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "like_count",              default: 0,     null: false
    t.integer  "view_count",              default: 0,     null: false
    t.boolean  "is_uncensored",           default: false, null: false
  end

  add_index "posts", ["created_at"], name: "index_posts_on_created_at", using: :btree
  add_index "posts", ["post_type_id"], name: "index_posts_on_post_type_id", using: :btree
  add_index "posts", ["updated_at"], name: "index_posts_on_updated_at", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "posts_tags", id: false, force: true do |t|
    t.integer "post_id", limit: 8, null: false
    t.integer "tag_id",            null: false
  end

  add_index "posts_tags", ["post_id"], name: "index_posts_tags_on_post_id", using: :btree
  add_index "posts_tags", ["tag_id"], name: "index_posts_tags_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name",       limit: 150, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "user_contacts", force: true do |t|
    t.integer  "user_id",    limit: 8, null: false
    t.text     "text",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_favorites", force: true do |t|
    t.integer  "user_id",         limit: 8, null: false
    t.integer  "post_id",         limit: 8
    t.integer  "post_content_id", limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_favorites", ["post_content_id"], name: "index_user_favorites_on_post_content_id", using: :btree
  add_index "user_favorites", ["post_id"], name: "index_user_favorites_on_post_id", using: :btree
  add_index "user_favorites", ["user_id"], name: "index_user_favorites_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "hash_value", limit: 40, null: false
    t.string   "name",       limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["hash_value"], name: "index_users_on_hash_value", unique: true, using: :btree

  create_table "xvideos", force: true do |t|
    t.integer  "video_id",              null: false
    t.string   "hash_value", limit: 40, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "xvideos", ["hash_value"], name: "index_xvideos_on_hash_value", unique: true, using: :btree
  add_index "xvideos", ["video_id"], name: "index_xvideos_on_video_id", unique: true, using: :btree

end
