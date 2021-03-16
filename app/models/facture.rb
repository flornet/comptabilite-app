class Facture < ApplicationRecord
  # attribute :client_updated_at_traker

  belongs_to :taxe
  belongs_to :facture_statut
  belongs_to :client
  belongs_to :user
  has_many :facture_lignes, inverse_of: :facture, dependent: :destroy
  accepts_nested_attributes_for :facture_lignes, :client, allow_destroy: true, reject_if: :all_blank

  before_validation :define_client_updated_at
  before_save :define_number_facture, :define_number_brouillon
  # after_save :define_client_updated_at

  def client_current_version
    self.client.paper_trail.version_at(self.date_version_client)
  end

  def generate_new_invoice_number
    Date.today.to_formatted_s(:number) + '-' + self.user.dernier_numero_facture.to_s.rjust(6, '0')
  end

  def define_client_updated_at
    Rails.logger.debug('_________________Facture (before validation_________________')
    if self.new_record? && !self.client.changed?
      self.date_version_client = self.client.updated_at
      Rails.logger.debug('___new record')
    end
    if self.client.changed?
      self.client.updated_at = Time.now.utc
      self.date_version_client = self.client.updated_at
      Rails.logger.debug('___changed')
    else
      Rails.logger.debug('___not changed')
    end
    Rails.logger.debug(self.date_version_client)
    Rails.logger.debug('_________________FIN_________________')
  end

  # def define_client_updated_at
  #   Rails.logger.debug('_________________DEBUT_________________')
  #   Rails.logger.debug(self.client_updated_at_traker)
  #   Rails.logger.debug(self.client.updated_at)
  #   Rails.logger.debug(self.client.created_at)
  #   if self.client_updated_at_traker != self.client.updated_at
  #     self.date_version_client = self.client.updated_at
  #     # self.save
  #   elsif self.client.updated_at == self.client.created_at
  #     self.date_version_client = self.client.created_at
  #     # self.save
  #   end
  #   # skip_callback :validate, :before, :check_membership, if: -> { self.age > 18 }
  #   # self.skip_callback()
  #   Rails.logger.debug(self.date_version_client)
  #   Rails.logger.debug('_________________FIN_________________')
  # end

  private
    def define_number_facture
      if !self.est_brouillon && (self.numero == '' || self.numero.start_with?('brouillon-'))
        self.numero = generate_new_invoice_number
        self.user.dernier_numero_facture += 1
        self.user.save
      end
    end

    def define_number_brouillon
      if self.est_brouillon && self.numero == ''
        self.numero = 'brouillon-' + Time.now.to_i.to_s
      end
    end

end
