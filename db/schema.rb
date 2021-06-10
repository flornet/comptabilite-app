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

ActiveRecord::Schema.define(version: 2021_06_10_151446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "nom", null: false
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
    t.index ["user_id", "nom"], name: "index_clients_on_user_id_and_nom", unique: true
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "depenses", force: :cascade do |t|
    t.date "date"
    t.string "libelle"
    t.string "commentaire"
    t.decimal "montant_ttc", default: "0.0"
    t.string "justificatif_nom"
    t.string "justificatif_type_contenu"
    t.binary "justificatif_data"
    t.boolean "rembourse", default: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_depenses_on_user_id"
  end

  create_table "devis", force: :cascade do |t|
    t.string "type_document"
    t.date "date"
    t.string "numero"
    t.string "designation"
    t.decimal "montant_ht", default: "0.0"
    t.decimal "montant_tva", default: "0.0"
    t.decimal "montant_ttc", default: "0.0"
    t.string "date_validite"
    t.text "coordonnees_societe"
    t.string "logo"
    t.string "contrast_color", default: "#000000", null: false
    t.text "mention1_texte"
    t.text "mention2_texte"
    t.text "mention3_texte"
    t.text "mention_legale"
    t.string "pdf"
    t.bigint "taxe_id", null: false
    t.bigint "devis_statut_id", null: false
    t.bigint "client_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "date_version_client"
    t.index ["client_id"], name: "index_devis_on_client_id"
    t.index ["devis_statut_id"], name: "index_devis_on_devis_statut_id"
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
    t.string "nom", null: false
    t.boolean "defaut", default: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "nom"], name: "index_devis_statuts_on_user_id_and_nom", unique: true
    t.index ["user_id"], name: "index_devis_statuts_on_user_id"
  end

  create_table "document_modeles", force: :cascade do |t|
    t.string "nom", null: false
    t.text "coordonnees_societe"
    t.string "logo"
    t.string "contrast_color", default: "#000000", null: false
    t.text "mention1_texte"
    t.text "mention2_texte"
    t.text "mention3_texte"
    t.text "mention_legale"
    t.boolean "defaut", default: false
    t.bigint "user_id"
    t.string "date_reglement"
    t.string "date_validite"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "nom"], name: "index_document_modeles_on_user_id_and_nom", unique: true
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
    t.string "nom", null: false
    t.boolean "defaut", default: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "exclure_statistiques", default: false
    t.index ["user_id", "nom"], name: "index_facture_statuts_on_user_id_and_nom", unique: true
    t.index ["user_id"], name: "index_facture_statuts_on_user_id"
  end

  create_table "factures", force: :cascade do |t|
    t.string "type_document"
    t.date "date"
    t.string "numero"
    t.string "designation"
    t.decimal "montant_ht", default: "0.0"
    t.decimal "montant_tva", default: "0.0"
    t.decimal "montant_ttc", default: "0.0"
    t.string "date_reglement"
    t.text "coordonnees_societe"
    t.string "logo"
    t.string "contrast_color", default: "#000000", null: false
    t.text "mention1_texte"
    t.text "mention2_texte"
    t.text "mention3_texte"
    t.text "mention_legale"
    t.string "pdf"
    t.boolean "est_brouillon", default: true, null: false
    t.bigint "taxe_id", null: false
    t.bigint "facture_statut_id", null: false
    t.bigint "client_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "date_version_client"
    t.index ["client_id"], name: "index_factures_on_client_id"
    t.index ["facture_statut_id"], name: "index_factures_on_facture_statut_id"
    t.index ["taxe_id"], name: "index_factures_on_taxe_id"
    t.index ["user_id", "numero"], name: "index_factures_on_user_id_and_numero", unique: true
    t.index ["user_id"], name: "index_factures_on_user_id"
  end

  create_table "taxes", force: :cascade do |t|
    t.string "nom", null: false
    t.decimal "taux", default: "0.0"
    t.boolean "defaut", default: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "nom"], name: "index_taxes_on_user_id_and_nom", unique: true
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
    t.integer "dernier_numero_facture", default: 1, null: false
    t.integer "dernier_numero_devis", default: 1, null: false
    t.string "code_naf_ape"
    t.string "numero_tva"
    t.string "numero_siren"
    t.string "numero_siret"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.text "object_changes"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "clients", "taxes", column: "taxe_id"
  add_foreign_key "clients", "users"
  add_foreign_key "depenses", "users"
  add_foreign_key "devis", "clients"
  add_foreign_key "devis", "devis_statuts"
  add_foreign_key "devis", "taxes", column: "taxe_id"
  add_foreign_key "devis", "users"
  add_foreign_key "devis_lignes", "devis", column: "devis_id"
  add_foreign_key "devis_statuts", "users"
  add_foreign_key "document_modeles", "users"
  add_foreign_key "facture_lignes", "factures"
  add_foreign_key "facture_statuts", "users"
  add_foreign_key "factures", "clients"
  add_foreign_key "factures", "facture_statuts"
  add_foreign_key "factures", "taxes", column: "taxe_id"
  add_foreign_key "factures", "users"
  add_foreign_key "taxes", "users"
end
