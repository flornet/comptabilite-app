class CreateDocumentModeles < ActiveRecord::Migration[6.1]
  def change
    create_table :document_modeles do |t|
      t.string :nom, null: false
      t.text :coordonnees_societe
      t.string :logo
      t.string :contrast_color, null: false, default: "#000000"
      t.text :mention1_texte
      t.text :mention2_texte
      t.text :mention3_texte
      t.text :mention_legale
      t.boolean :defaut, :default => false
      t.references :user, foreign_key: true
      t.string :date_reglement
      t.string :date_validite

      t.timestamps
    end
  end
end
