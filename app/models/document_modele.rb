class DocumentModele < ApplicationRecord
  validates :nom,  :presence => true
  belongs_to :user
end
