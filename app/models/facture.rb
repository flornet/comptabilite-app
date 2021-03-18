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

  def client_current_version
    self.client.paper_trail.version_at(self.date_version_client)
  end

  def generate_new_invoice_number
    Date.today.to_formatted_s(:number) + '-' + self.user.dernier_numero_facture.to_s.rjust(6, '0')
  end

  def update_from_nested_params(params, est_brouillon = false)
    if !params[:client_attributes].nil?
      if params[:client_attributes][:id] == ""
        # Creating a new associated client
        self.client = self.user.clients.build() #Client.new
        self.client.assign_attributes(params[:client_attributes])
        self.client.taxe = self.taxe
        params.delete :client_attributes
      elsif params[:client_attributes][:id] != self.client.id
        # Changing the associated client
        client = Client.find(params[:client_attributes][:id])
        client.assign_attributes(params[:client_attributes])
        params.delete :client_attributes
        self.client = client
      end
    end
    self.est_brouillon = est_brouillon
    return self.update(params)
  end

  private

    def define_number_facture
      if !self.est_brouillon && (self.numero.nil? || self.numero == '' || self.numero.start_with?('brouillon-'))
        self.numero = generate_new_invoice_number
        self.user.dernier_numero_facture += 1
        self.user.save
      end
    end

    def define_number_brouillon
      if self.est_brouillon && self.numero.nil?
        self.numero = 'brouillon-' + Time.now.to_i.to_s
      end
    end

    def define_client_updated_at
      if !self.client.nil?
        if self.new_record? && !self.client.changed?
          self.date_version_client = self.client.updated_at
        end
        if self.client.changed?
          self.client.updated_at = Time.now.utc
          self.date_version_client = self.client.updated_at
        end
      end
    end

end
