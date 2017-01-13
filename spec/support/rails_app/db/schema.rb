ActiveRecord::Schema.define(version: 1) do
  begin
    drop_table :admins
  rescue
  end

  create_table "admins", force: true do |t|
    t.string   "username"
    t.string   "facebook_token"
    t.string   "email",                            default: "", null: false
    t.string   "unconfirmed_email",                default: ""
    t.string   "encrypted_password",   limit: 128, default: "", null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                  default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end
