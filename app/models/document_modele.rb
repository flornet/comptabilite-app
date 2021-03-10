class DocumentModele < ApplicationRecord
  validates :nom,  :presence => true
  validates :modele, :presence => true
  belongs_to :user
end
