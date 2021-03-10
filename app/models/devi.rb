class Devi < ApplicationRecord
  belongs_to :document_modele
  belongs_to :taxe
  belongs_to :devis_statut
  belongs_to :client
  belongs_to :user
  has_many :devis_lignes, dependent: :destroy
end
