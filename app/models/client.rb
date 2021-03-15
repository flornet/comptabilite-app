class Client < ApplicationRecord
  belongs_to :taxe
  belongs_to :user
  has_many :factures
  has_many :devis

  validates :nom,  :presence => true
  validates :nom, uniqueness: { case_sensitive: false }

  scope :filtered, ->(query_params) { Client::Filter.new.filter(self, query_params) }
end
