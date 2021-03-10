class Facture < ApplicationRecord
  belongs_to :document_modele
  belongs_to :taxe
  belongs_to :facture_statut
  belongs_to :client
  belongs_to :user
  has_many :facture_lignes, inverse_of: :facture, dependent: :destroy
  accepts_nested_attributes_for :facture_lignes, :client, allow_destroy: true, reject_if: :all_blank
end
