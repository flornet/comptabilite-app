class Devi < ApplicationRecord
  belongs_to :taxe
  belongs_to :devis_statut
  belongs_to :client
  belongs_to :user
  has_many :devis_lignes, :foreign_key => "devis_id", inverse_of: :devis, dependent: :destroy

  accepts_nested_attributes_for :devis_lignes, :client, allow_destroy: true, reject_if: :all_blank

  before_validation :define_client_updated_at
  before_save :define_number_devis

  def client_current_version
    self.client.paper_trail.version_at(self.date_version_client)
  end

  def generate_new_devis_number
    Date.today.to_formatted_s(:number) + '-' + self.user.dernier_numero_devis.to_s.rjust(6, '0')
  end

  def update_from_nested_params(params)
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
    return self.update(params)
  end

  def duplicate
    replica = dup
    devis_lignes.each do |devis_ligne|
      replica.devis_lignes << devis_ligne.dup
    end
    replica.date    = Date.today
    replica.numero  = replica.generate_new_devis_number
    replica
  end

  private

    def define_number_devis
      if (self.numero.nil? || self.numero == '')
        self.numero = generate_new_devis_number
        self.user.dernier_numero_devis += 1
        self.user.save
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
