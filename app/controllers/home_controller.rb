class HomeController < ApplicationController
  def index
  end

  def setup_data
    Taxe.create(nom: "20%", taux: "0.20", defaut: true, user: current_user)
    Taxe.create(nom: "10%", taux: "0.10", user: current_user)
    Taxe.create(nom: "5.5%", taux: "0.055", user: current_user)
    Taxe.create(nom: "2.1%", taux: "0.021", user: current_user)
    Taxe.create(nom: "0%", taux: "0", user: current_user)

    FactureStatut.create(nom: "brouillon", user: current_user)
    FactureStatut.create(nom: "envoyée", user: current_user)
    FactureStatut.create(nom: "payée", user: current_user)
    FactureStatut.create(nom: "enregistrée", defaut: true, user: current_user)
    FactureStatut.create(nom: "annulée", user: current_user)

    DevisStatut.create(nom: "envoyé", user: current_user)
    DevisStatut.create(nom: "signé", user: current_user)
    DevisStatut.create(nom: "non envoyé", defaut: true, user: current_user)
    DevisStatut.create(nom: "annulé", user: current_user)

    DocumentModele.create(nom: "We Love Users", logo: "wlu-logo.png",
coordonnees_societe: "EURL WE LOVE USERS
95 AVENUE DE SAINT-OUEN
75017 PARIS
Tel: 06 37 33 26 55
@: f.jaouali@weloveusers.com",
mention1_texte: "RIB : 16958 00001 97153429177 16
IBAN - BIC : FR76 1695 8000 0197 1534 2917 716 - QNTOFRP1XXX",
mention1_active: true,
mention2_texte: "En cas de retard de paiement, une pénalité de 3 fois le taux d'intérêt légal sera appliquée, à laquelle s'ajoutera une indemnité forfaitaire pour frais de recouvrement de 40 €.
Pas d'escompte en cas de paiement anticipé",
mention2_active: true,
mention3_active: false,
mention_legale: "EURL au capital de 5 000 euros
Siret : 810 746 388 00018 - RCS : PARIS - NAF : 7022Z
TVA Intracommunautaire : FR 66 810 746 388", modele: "weloveusers", user: current_user)
    DocumentModele.create(nom: "Luminose", logo: "luminose-logo.png",
coordonnees_societe: "EURL WE LOVE USERS
95 AVENUE DE SAINT-OUEN
75017 PARIS
Tel: 06 37 33 26 55
@: f.jaouali@weloveusers.com",
mention1_texte: "",
mention1_active: false,
mention2_texte: "En cas de retard de paiement, une pénalité de 3 fois le taux d'intérêt légal sera appliquée, à laquelle s'ajoutera une indemnité forfaitaire pour frais de recouvrement de 40 €.
Pas d'escompte en cas de paiement anticipé",
mention2_active: true,
mention3_active: false,
mention_legale: "EURL au capital de 5 000 euros
Siret : 810 746 388 00018 - RCS : PARIS - NAF : 7022Z
TVA Intracommunautaire : FR 66 810 746 388", modele: "luminose", user: current_user)
    respond_to do |format|
      format.html { redirect_to root_url, notice: "Les données par défaut ont été chargées." }
      format.json { head :no_content }
    end
  end
end
