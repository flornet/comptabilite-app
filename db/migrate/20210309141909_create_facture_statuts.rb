class CreateFactureStatuts < ActiveRecord::Migration[6.1]
  def change
    create_table :facture_statuts do |t|
      t.string :nom
      t.boolean :defaut, :default => false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
