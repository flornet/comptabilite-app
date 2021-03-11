class Facture < ApplicationRecord
  belongs_to :taxe
  belongs_to :facture_statut
  belongs_to :client
  belongs_to :user
  has_many :facture_lignes, inverse_of: :facture, dependent: :destroy
  accepts_nested_attributes_for :facture_lignes, :client, allow_destroy: true, reject_if: :all_blank

  before_save :define_number_facture
  after_create :define_number_brouillon

  private
    def define_number_facture
      if !self.est_brouillon
        self.numero = generate_new_invoice_number
        self.user.dernier_numero_facture += 1
        self.user.save
      end
    end

    def define_number_brouillon
      if self.est_brouillon
        self.numero = 'brouillon-' + self.id.to_s
        self.save
      end
    end

    def generate_new_invoice_number
      Date.today.to_formatted_s(:number) + '-' + self.user.dernier_numero_facture.to_s.rjust(6, '0')
    end

    # def set_number
    #   self.numero = Date.today.to_formatted_s(:number) + '-' + self.id.to_s.rjust(6, '0')
    #   self.save
    # end
end
