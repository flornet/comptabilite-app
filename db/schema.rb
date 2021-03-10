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

ActiveRecord::Schema.define(version: 2021_03_10_092327) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "nom"
    t.text "adresse"
    t.string "code_postal"
    t.string "ville"
    t.string "pays"
    t.string "numero_tva_intracommunautaire"
    t.string "email"
    t.string "telephone"
    t.bigint "taxe_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["taxe_id"], name: "index_clients_on_taxe_id"
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "devis", force: :cascade do |t|
    t.string "type_document"
    t.date "date"
    t.string "numero"
    t.string "designation"
    t.decimal "montant_ht"
    t.decimal "montant_ttc"
    t.bigint "document_modele_id", null: false
    t.string "pdf"
    t.bigint "taxe_id", null: false
    t.bigint "devis_statut_id", null: false
    t.bigint "client_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_devis_on_client_id"
    t.index ["devis_statut_id"], name: "index_devis_on_devis_statut_id"
    t.index ["document_modele_id"], name: "index_devis_on_document_modele_id"
    t.index ["taxe_id"], name: "index_devis_on_taxe_id"
    t.index ["user_id", "numero"], name: "index_devis_on_user_id_and_numero", unique: true
    t.index ["user_id"], name: "index_devis_on_user_id"
  end

  create_table "devis_lignes", force: :cascade do |t|
    t.bigint "devis_id", null: false
    t.text "designation"
    t.decimal "montant_ht"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["devis_id"], name: "index_devis_lignes_on_devis_id"
  end

  create_table "devis_statuts", force: :cascade do |t|
    t.string "nom"
    t.boolean "defaut", default: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_devis_statuts_on_user_id"
  end

  create_table "document_modeles", force: :cascade do |t|
    t.string "nom"
    t.text "coordonnees_societe"
    t.string "logo"
    t.text "mention1_texte"
    t.boolean "mention1_active", default: false
    t.text "mention2_texte"
    t.boolean "mention2_active", default: false
    t.text "mention3_texte"
    t.boolean "mention3_active", default: false
    t.string "mention_legale"
    t.string "modele"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_document_modeles_on_user_id"
  end

  create_table "facture_lignes", force: :cascade do |t|
    t.bigint "facture_id", null: false
    t.text "designation"
    t.decimal "montant_ht"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["facture_id"], name: "index_facture_lignes_on_facture_id"
  end

  create_table "facture_statuts", force: :cascade do |t|
    t.string "nom"
    t.boolean "defaut", default: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_facture_statuts_on_user_id"
  end

  create_table "factures", force: :cascade do |t|
    t.string "type_document"
    t.date "date"
    t.string "numero"
    t.string "designation"
    t.decimal "montant_ht"
    t.decimal "montant_ttc"
    t.bigint "document_modele_id", null: false
    t.string "pdf"
    t.bigint "taxe_id", null: false
    t.bigint "facture_statut_id", null: false
    t.bigint "client_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_factures_on_client_id"
    t.index ["document_modele_id"], name: "index_factures_on_document_modele_id"
    t.index ["facture_statut_id"], name: "index_factures_on_facture_statut_id"
    t.index ["taxe_id"], name: "index_factures_on_taxe_id"
    t.index ["user_id", "numero"], name: "index_factures_on_user_id_and_numero", unique: true
    t.index ["user_id"], name: "index_factures_on_user_id"
  end

  create_table "taxes", force: :cascade do |t|
    t.string "nom"
    t.decimal "taux"
    t.boolean "defaut", default: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_taxes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "clients", "taxes", column: "taxe_id"
  add_foreign_key "clients", "users"
  add_foreign_key "devis", "clients"
  add_foreign_key "devis", "devis_statuts"
  add_foreign_key "devis", "document_modeles"
  add_foreign_key "devis", "taxes", column: "taxe_id"
  add_foreign_key "devis", "users"
  add_foreign_key "devis_lignes", "devis", column: "devis_id"
  add_foreign_key "devis_statuts", "users"
  add_foreign_key "document_modeles", "users"
  add_foreign_key "facture_lignes", "factures"
  add_foreign_key "facture_statuts", "users"
  add_foreign_key "factures", "clients"
  add_foreign_key "factures", "document_modeles"
  add_foreign_key "factures", "facture_statuts"
  add_foreign_key "factures", "taxes", column: "taxe_id"
  add_foreign_key "factures", "users"
  add_foreign_key "taxes", "users"
end
