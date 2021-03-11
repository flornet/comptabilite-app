class CreateDocumentModeles < ActiveRecord::Migration[6.1]
  def change
    create_table :document_modeles do |t|
      t.string :nom
      t.text :coordonnees_societe
      t.string :logo
      t.text :mention1_texte
      t.boolean :mention1_active, :default => false
      t.text :mention2_texte
      t.boolean :mention2_active, :default => false
      t.text :mention3_texte
      t.boolean :mention3_active, :default => false
      t.string :mention_legale
      t.string :modele
      t.boolean :defaut, :default => false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
