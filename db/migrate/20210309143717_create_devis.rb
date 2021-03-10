class CreateDevis < ActiveRecord::Migration[6.1]
  def change
    create_table :devis do |t|
      t.string :type_document
      t.date :date
      t.string :numero
      t.string :designation
      t.decimal :montant_ht
      t.decimal :montant_ttc
      t.references :document_modele, null: false, foreign_key: true
      t.string :pdf
      t.references :taxe, null: false, foreign_key: true
      t.references :devis_statut, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
