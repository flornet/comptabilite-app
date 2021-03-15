class CreateDevis < ActiveRecord::Migration[6.1]
  def change
    create_table :devis do |t|
      t.string :type_document
      t.date :date
      t.string :numero
      t.string :designation
      t.decimal :montant_ht, :default => 0
      t.decimal :montant_tva, :default => 0
      t.decimal :montant_ttc, :default => 0
      t.string :date_validite

      t.text :coordonnees_societe
      t.string :logo
      t.text :mention1_texte
      t.text :mention2_texte
      t.text :mention3_texte
      t.text :mention_legale

      t.string :pdf
      t.references :taxe, null: false, foreign_key: true
      t.references :devis_statut, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
