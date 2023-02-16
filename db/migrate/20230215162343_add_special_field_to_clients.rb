class AddSpecialFieldToClients < ActiveRecord::Migration[7.0]
  def change
    change_table :clients do |t|
      t.boolean :special, null: false, default: 0
    end
  end
end
