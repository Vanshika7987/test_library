# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_03_22_085507) do
  create_table "book_dues", force: :cascade do |t|
    t.integer "book_id"
    t.integer "students_id_id"
    t.integer "fine"
    t.datetime "return_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_book_dues_on_book_id"
    t.index ["students_id_id"], name: "index_book_dues_on_students_id_id"
  end

  create_table "book_requests", force: :cascade do |t|
    t.integer "book_id"
    t.integer "library_id"
    t.integer "students_id"
    t.datetime "request_to"
    t.datetime "request_from"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "request_for"
    t.index ["book_id"], name: "index_book_requests_on_book_id"
    t.index ["deleted_at"], name: "index_book_requests_on_deleted_at"
    t.index ["library_id"], name: "index_book_requests_on_library_id"
    t.index ["students_id"], name: "index_book_requests_on_students_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "name"
    t.string "author"
    t.string "language"
    t.integer "library_id"
    t.datetime "issued_from_at"
    t.datetime "issued_to_at"
    t.integer "issued_to_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issued_to_id"], name: "index_books_on_issued_to_id"
    t.index ["library_id"], name: "index_books_on_library_id"
  end

  create_table "histories", force: :cascade do |t|
    t.integer "book_id"
    t.integer "issued_to_id"
    t.datetime "issued_from_at"
    t.datetime "issued_to_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "event"
    t.index ["book_id"], name: "index_histories_on_book_id"
    t.index ["issued_to_id"], name: "index_histories_on_issued_to_id"
  end

  create_table "libraries", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "librarian_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["librarian_id"], name: "index_libraries_on_librarian_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "role", default: 0
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "book_dues", "books"
  add_foreign_key "book_dues", "users", column: "students_id_id"
  add_foreign_key "book_requests", "books"
  add_foreign_key "book_requests", "libraries"
  add_foreign_key "book_requests", "users", column: "students_id"
  add_foreign_key "books", "libraries"
  add_foreign_key "books", "users", column: "issued_to_id"
  add_foreign_key "histories", "books"
  add_foreign_key "histories", "users", column: "issued_to_id"
  add_foreign_key "libraries", "users", column: "librarian_id"
end
