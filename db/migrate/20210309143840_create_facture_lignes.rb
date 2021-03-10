class CreateFactureLignes < ActiveRecord::Migration[6.1]
  def change
    create_table :facture_lignes do |t|
      t.references :facture, null: false, foreign_key: true
      t.text :designation
      t.decimal :montant_ht

      t.timestamps
    end
  end
end
