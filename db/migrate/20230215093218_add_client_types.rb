class AddClientTypes < ActiveRecord::Migration[6.1]
  def change
    change_table :clients do |t|
      t.boolean :prestation_hypnose, null: false, default: 0
      t.boolean :prestation_boutique, null: false, default: 0
      t.boolean :prestation_ux, null: false, default: 0
    end
  end
end
