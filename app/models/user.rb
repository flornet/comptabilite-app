class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :taxes, class_name: "Taxe", dependent: :destroy
  has_many :factures, dependent: :destroy
  has_many :document_modeles, dependent: :destroy
  has_many :devis, dependent: :destroy
  has_many :clients, dependent: :destroy
  has_many :facture_statuts, dependent: :destroy
  has_many :devis_statuts, dependent: :destroy
end
