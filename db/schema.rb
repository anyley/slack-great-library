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

ActiveRecord::Schema.define(version: 20161003222255) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaigns", force: :cascade do |t|
    t.string   "uuid"
    t.integer  "item_id"
    t.integer  "initiator_id"
    t.integer  "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["initiator_id"], name: "index_campaigns_on_initiator_id", using: :btree
    t.index ["item_id"], name: "index_campaigns_on_item_id", using: :btree
  end

  create_table "campaigns_users", force: :cascade do |t|
    t.integer  "campaign_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["campaign_id", "user_id"], name: "index_campaigns_users_on_campaign_id_and_user_id", unique: true, using: :btree
    t.index ["campaign_id"], name: "index_campaigns_users_on_campaign_id", using: :btree
    t.index ["user_id"], name: "index_campaigns_users_on_user_id", using: :btree
  end

  create_table "claims", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id", "user_id"], name: "index_claims_on_item_id_and_user_id", unique: true, using: :btree
    t.index ["item_id"], name: "index_claims_on_item_id", using: :btree
    t.index ["user_id"], name: "index_claims_on_user_id", using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.string   "description"
    t.string   "url"
    t.integer  "price"
    t.string   "valute"
    t.string   "itemtype"
    t.integer  "offered_by_id"
    t.string   "filename"
    t.string   "mime_type"
    t.binary   "data"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["description"], name: "index_items_on_description", using: :btree
    t.index ["itemtype"], name: "index_items_on_itemtype", using: :btree
    t.index ["offered_by_id"], name: "index_items_on_offered_by_id", using: :btree
  end

  create_table "items_users", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_items_users_on_item_id", using: :btree
    t.index ["user_id"], name: "index_items_users_on_user_id", using: :btree
  end

  create_table "operations", force: :cascade do |t|
    t.integer  "op_type"
    t.integer  "sum"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.datetime "date"
    t.string   "uuid"
    t.boolean  "accept"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["receiver_id"], name: "index_operations_on_receiver_id", using: :btree
    t.index ["sender_id"], name: "index_operations_on_sender_id", using: :btree
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "operation_id"
    t.integer  "campaign_id"
    t.integer  "item_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["campaign_id"], name: "index_purchases_on_campaign_id", using: :btree
    t.index ["item_id", "user_id"], name: "index_purchases_on_item_id_and_user_id", unique: true, using: :btree
    t.index ["item_id"], name: "index_purchases_on_item_id", using: :btree
    t.index ["operation_id"], name: "index_purchases_on_operation_id", using: :btree
    t.index ["user_id"], name: "index_purchases_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "campaigns", "items", on_delete: :nullify
  add_foreign_key "campaigns", "users", column: "initiator_id", on_delete: :nullify
  add_foreign_key "campaigns_users", "campaigns", on_delete: :cascade
  add_foreign_key "campaigns_users", "users", on_delete: :cascade
  add_foreign_key "claims", "items", on_delete: :cascade
  add_foreign_key "claims", "users", on_delete: :cascade
  add_foreign_key "items", "users", column: "offered_by_id", on_delete: :nullify
  add_foreign_key "items_users", "items", on_delete: :cascade
  add_foreign_key "items_users", "users", on_delete: :cascade
  add_foreign_key "operations", "users", column: "receiver_id", on_delete: :nullify
  add_foreign_key "operations", "users", column: "sender_id", on_delete: :nullify
  add_foreign_key "purchases", "campaigns", on_delete: :nullify
  add_foreign_key "purchases", "items", on_delete: :cascade
  add_foreign_key "purchases", "operations", on_delete: :nullify
  add_foreign_key "purchases", "users", on_delete: :cascade
end
