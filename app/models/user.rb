class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable
  has_many :taxes, class_name: "Taxe", dependent: :destroy
  has_many :factures, dependent: :destroy do

    def build_with_model(model)
      facture = build
      facture.facture_lignes.build
      facture.build_client
      facture.facture_statut      = facture.user.facture_statuts.where(defaut: true).first
      facture.taxe                = facture.user.taxes.where(defaut: true).first
      facture.coordonnees_societe = model.coordonnees_societe
      facture.logo                = model.logo
      facture.contrast_color      = model.contrast_color
      facture.date_reglement      = model.date_reglement
      facture.mention1_texte      = model.mention1_texte
      facture.mention2_texte      = model.mention2_texte
      facture.mention3_texte      = model.mention3_texte
      facture.mention_legale      = model.mention_legale
      facture.date                = Date.today
      facture.numero              = facture.generate_new_invoice_number
      facture
    end

    def build_from_create_params(params, est_brouillon = false)
      if params[:client_attributes][:id] != ""
        # Client already existing to link and possibly update
        client = Client.find(params[:client_attributes][:id])
        client.assign_attributes(params[:client_attributes])
        params.delete :client_attributes
        facture = proxy_association.owner.factures.build(params)
        facture.client = client
      else
        # New client to create
        facture = proxy_association.owner.factures.build(params)
      end

      if !facture.client
        facture.build_client()
      end

      if facture.facture_lignes.size <= 0
        facture.facture_lignes.build
      end

      facture.client.taxe = facture.taxe
      facture.client.user = facture.user
      facture.facture_statut = facture.user.facture_statuts.where(defaut: true).first
      facture.est_brouillon = est_brouillon

      return facture
    end

  end
  has_many :devis, dependent: :destroy do

    def build_with_model(model)
      devis = build
      devis.devis_lignes.build
      devis.build_client
      devis.devis_statut        = devis.user.devis_statuts.where(defaut: true).first
      devis.taxe                = devis.user.taxes.where(defaut: true).first
      devis.coordonnees_societe = model.coordonnees_societe
      devis.logo                = model.logo
      devis.contrast_color      = model.contrast_color
      devis.date_validite       = model.date_validite
      devis.mention1_texte      = ""
      devis.mention2_texte      = ""
      devis.mention3_texte      = ""
      devis.mention_legale      = model.mention_legale
      devis.date                = Date.today
      devis.numero              = devis.generate_new_devis_number
      devis
    end

    def build_from_create_params(params)
      if params[:client_attributes][:id] != ""
        # Client already existing to link and possibly update
        client = Client.find(params[:client_attributes][:id])
        client.assign_attributes(params[:client_attributes])
        params.delete :client_attributes
        devis = proxy_association.owner.devis.build(params)
        devis.client = client
      else
        # New client to create
        devis = proxy_association.owner.devis.build(params)
      end

      if !devis.client
        devis.build_client()
      end

      if devis.devis_lignes.size <= 0
        devis.devis_lignes.build
      end

      devis.client.taxe = devis.taxe
      devis.client.user = devis.user
      devis.devis_statut = devis.user.devis_statuts.where(defaut: true).first

      return devis
    end

  end
  has_many :document_modeles, dependent: :destroy
  has_many :clients, dependent: :destroy
  has_many :facture_statuts, dependent: :destroy
  has_many :devis_statuts, dependent: :destroy

  after_create :setup_data

  def setup_data
    Taxe.create(nom: "20%", taux: "0.20", defaut: true, user: self)
    Taxe.create(nom: "10%", taux: "0.10", user: self)
    Taxe.create(nom: "5.5%", taux: "0.055", user: self)
    Taxe.create(nom: "2.1%", taux: "0.021", user: self)
    Taxe.create(nom: "0%", taux: "0", user: self)

    FactureStatut.create(nom: "Envoyée", user: self)
    FactureStatut.create(nom: "Payée", user: self)
    FactureStatut.create(nom: "Enregistrée", defaut: true, user: self)
    FactureStatut.create(nom: "Annulée", user: self)

    DevisStatut.create(nom: "Envoyé", user: self)
    DevisStatut.create(nom: "Signé", user: self)
    DevisStatut.create(nom: "Non envoyé", defaut: true, user: self)
    DevisStatut.create(nom: "Annulé", user: self)

    DocumentModele.create(
      nom:                  "We Love Users",
      logo:                 "wlu-logo.png",
      contrast_color:       "#70d4af",
      coordonnees_societe:  "EURL WE LOVE USERS
95 AVENUE DE SAINT-OUEN
75017 PARIS
Tel: 06 37 33 26 55
@: f.jaouali@weloveusers.com",
      mention1_texte:       "",
      mention2_texte:       "RIB : 16958 00001 97153429177 16
IBAN - BIC : FR76 1695 8000 0197 1534 2917 716 - QNTOFRP1XXX",
      mention3_texte:       "En cas de retard de paiement, une pénalité de 3 fois le taux d'intérêt légal sera appliquée, à laquelle s'ajoutera une indemnité forfaitaire pour frais de recouvrement de 40 €.
Pas d'escompte en cas de paiement anticipé",
      mention_legale:       "EURL au capital de 5 000 euros
Siret : 810 746 388 00018 - RCS : PARIS - NAF : 7022Z
TVA Intracommunautaire : FR 66 810 746 388",
      user:                 self,
      defaut:               true,
      date_reglement:       "A réception",
      date_validite:        "30 jours")
    DocumentModele.create(
      nom:                  "Luminose",
      logo:                 "luminose-logo.png",
      contrast_color:       "#60407f",
      coordonnees_societe:  "EURL WE LOVE USERS
95 AVENUE DE SAINT-OUEN
75017 PARIS
Tel: 06 37 33 26 55
@: f.jaouali@weloveusers.com",
      mention1_texte:       "",
      mention2_texte:       "",
      mention3_texte:       "En cas de retard de paiement, une pénalité de 3 fois le taux d'intérêt légal sera appliquée, à laquelle s'ajoutera une indemnité forfaitaire pour frais de recouvrement de 40 €.
Pas d'escompte en cas de paiement anticipé",
      mention_legale:       "EURL au capital de 5 000 euros
Siret : 810 746 388 00018 - RCS : PARIS - NAF : 7022Z
TVA Intracommunautaire : FR 66 810 746 388",
      user:                 self,
      date_reglement:       "A réception",
      date_validite:        "30 jours")
  end
end
