class DevisStatut < ApplicationRecord
  validates :nom,  :presence => true
  belongs_to :user
end
