class CreateFactures < ActiveRecord::Migration[6.1]
  def change
    create_table :factures do |t|
      t.string :type_document
      t.date :date
      t.string :numero
      t.string :designation
      t.decimal :montant_ht
      t.decimal :montant_ttc

      t.text :coordonnees_societe
      t.string :logo
      t.text :mention1_texte
      t.boolean :mention1_active, :default => false
      t.text :mention2_texte
      t.boolean :mention2_active, :default => false
      t.text :mention3_texte
      t.boolean :mention3_active, :default => false
      t.string :mention_legale

      t.string :pdf
      t.references :taxe, null: false, foreign_key: true
      t.references :facture_statut, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
