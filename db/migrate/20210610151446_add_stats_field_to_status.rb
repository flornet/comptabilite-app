class AddStatsFieldToStatus < ActiveRecord::Migration[6.1]
  def change
    change_table :facture_statuts do |t|
      t.boolean :exclure_statistiques, :default => false
    end
  end
end
