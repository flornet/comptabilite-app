class DevisLigne < ApplicationRecord
  belongs_to :devis, :class_name => "Devi"
end
