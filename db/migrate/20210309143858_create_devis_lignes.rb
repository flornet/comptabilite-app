class CreateDevisLignes < ActiveRecord::Migration[6.1]
  def change
    create_table :devis_lignes do |t|
      t.references :devis, null: false, foreign_key: true
      t.text :designation
      t.decimal :montant_ht

      t.timestamps
    end
  end
end
