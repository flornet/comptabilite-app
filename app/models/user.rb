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

  after_create :setup_data

  def setup_data
    Taxe.create(nom: "20%", taux: "0.20", defaut: true, user: self)
    Taxe.create(nom: "10%", taux: "0.10", user: self)
    Taxe.create(nom: "5.5%", taux: "0.055", user: self)
    Taxe.create(nom: "2.1%", taux: "0.021", user: self)
    Taxe.create(nom: "0%", taux: "0", user: self)

    FactureStatut.create(nom: "envoyée", user: self)
    FactureStatut.create(nom: "payée", user: self)
    FactureStatut.create(nom: "enregistrée", defaut: true, user: self)
    FactureStatut.create(nom: "annulée", user: self)

    DevisStatut.create(nom: "envoyé", user: self)
    DevisStatut.create(nom: "signé", user: self)
    DevisStatut.create(nom: "non envoyé", defaut: true, user: self)
    DevisStatut.create(nom: "annulé", user: self)

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
