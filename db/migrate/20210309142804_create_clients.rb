class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.string :nom
      t.text :adresse
      t.string :code_postal
      t.string :ville
      t.string :pays
      t.string :numero_tva_intracommunautaire
      t.string :email
      t.string :telephone
      t.references :taxe, null: false, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
