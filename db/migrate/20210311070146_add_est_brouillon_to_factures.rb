class AddEstBrouillonToFactures < ActiveRecord::Migration[6.1]
  def change
    change_table :factures do |t|
      t.boolean :est_brouillon, null: false, default: 1
    end
  end
end
