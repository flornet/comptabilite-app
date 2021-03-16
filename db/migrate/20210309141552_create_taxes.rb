class CreateTaxes < ActiveRecord::Migration[6.1]
  def change
    create_table :taxes do |t|
      t.string :nom, null: false
      t.decimal :taux, :default => 0
      t.boolean :defaut, :default => false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
