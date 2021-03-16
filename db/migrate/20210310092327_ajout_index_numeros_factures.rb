class AjoutIndexNumerosFactures < ActiveRecord::Migration[6.1]
  def change
    add_index :clients,           [:user_id, :nom], unique: true
    add_index :factures,          [:user_id, :numero], unique: true
    add_index :devis,             [:user_id, :numero], unique: true
    add_index :facture_statuts,   [:user_id, :nom], unique: true
    add_index :devis_statuts,     [:user_id, :nom], unique: true
    add_index :taxes,             [:user_id, :nom], unique: true
    add_index :document_modeles,  [:user_id, :nom], unique: true
  end
end
