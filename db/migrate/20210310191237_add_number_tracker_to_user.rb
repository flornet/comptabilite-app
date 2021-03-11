class AddNumberTrackerToUser < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.integer :dernier_numero_facture, null: false, default: 1
      t.integer :dernier_numero_devis, null: false, default: 1
    end
  end
end
