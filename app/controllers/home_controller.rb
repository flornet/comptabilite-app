class HomeController < ApplicationController
  def index
    @facture_statuts = current_user.facture_statuts.where({ exclure_statistiques: false });
    @ca_ht_annuel = current_user.factures.where({ date: Date.today.beginning_of_year..Date.today.end_of_year, est_brouillon: false, facture_statut: @facture_statuts }).sum(:montant_ht)
    @ca_ht_mensuel = current_user.factures.where({ date: Date.today.beginning_of_month..Date.today.end_of_month, est_brouillon: false, facture_statut: @facture_statuts }).sum(:montant_ht)
    @graph_ca_ht_mensuel = current_user.factures.where({ est_brouillon: false, facture_statut: @facture_statuts }).group_by_month(:date, format: "%B", range:Date.today.beginning_of_year..Date.today.end_of_year).sum(:montant_ht)
  end

end
