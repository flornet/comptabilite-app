class AddClientVersionToFactureDevis < ActiveRecord::Migration[6.1]
  def change
    change_table :factures do |t|
      t.datetime :date_version_client
    end

    change_table :devis do |t|
      t.datetime :date_version_client
    end
  end
end
