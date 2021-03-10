class Taxe < ApplicationRecord
  validates :nom,  :presence => true
  validates :taux, :presence => true
  belongs_to :user
end
