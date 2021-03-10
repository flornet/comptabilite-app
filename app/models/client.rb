class Client < ApplicationRecord
  belongs_to :taxe
  belongs_to :user
  has_many :factures
  has_many :devis

  validates :nom,  :presence => true
  validates :nom, uniqueness: { case_sensitive: false }
end
