class AddContrastColorToModels < ActiveRecord::Migration[6.1]
  def change
    change_table :document_modeles do |t|
      t.string :contrast_color, null: false, default: "#000000"
    end
    change_table :devis do |t|
      t.string :contrast_color, null: false, default: "#000000"
    end
    change_table :factures do |t|
      t.string :contrast_color, null: false, default: "#000000"
    end
  end
end
