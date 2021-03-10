class AjoutIndexNumerosFactures < ActiveRecord::Migration[6.1]
  def change
    add_index :factures, [:user_id, :numero], unique: true
    add_index :devis, [:user_id, :numero], unique: true
  end
end
