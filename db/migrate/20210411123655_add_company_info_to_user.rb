class AddCompanyInfoToUser < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.string :code_naf_ape
      t.string :numero_tva
      t.string :numero_siren
      t.string :numero_siret
    end
  end
end
