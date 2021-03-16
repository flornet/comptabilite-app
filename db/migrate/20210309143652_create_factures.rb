class CreateFactures < ActiveRecord::Migration[6.1]
  def change
    create_table :factures do |t|
      t.string :type_document
      t.date :date
      t.string :numero
      t.string :designation
      t.decimal :montant_ht, :default => 0
      t.decimal :montant_tva, :default => 0
      t.decimal :montant_ttc, :default => 0
      t.string :date_reglement

      t.text :coordonnees_societe
      t.string :logo
      t.string :contrast_color, null: false, default: "#000000"
      t.text :mention1_texte
      t.text :mention2_texte
      t.text :mention3_texte
      t.text :mention_legale

      t.string :pdf
      t.boolean :est_brouillon, null: false, default: 1
      t.references :taxe, null: false, foreign_key: true
      t.references :facture_statut, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
