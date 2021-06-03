class CreateDepenses < ActiveRecord::Migration[6.1]
  def change
    create_table :depenses do |t|
      t.date :date
      t.string :libelle
      t.string :commentaire
      t.decimal :montant_ttc, :default => 0
      t.string :justificatif_nom
      t.string :justificatif_type_contenu
      t.binary :justificatif_data
      t.boolean :rembourse, :default => false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
