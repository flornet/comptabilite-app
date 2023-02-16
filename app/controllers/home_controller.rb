class HomeController < ApplicationController
  def index
    @params = params
    @selected_date = Date.today
    if (params[:selected_year] != nil)
      @selected_date = Date.new(params[:selected_year].to_i, Date.today.month, Date.today.day)
    end
    
    # @depenses = current_user.depenses.where('extract(year from date) = ?', @selected_year).order(date: "DESC", id: "DESC")
    
    @facture_statuts = current_user.facture_statuts.where({ exclure_statistiques: false });
    @ca_ht_annuel = current_user.factures.where({ date: @selected_date.beginning_of_year..@selected_date.end_of_year, est_brouillon: false, facture_statut: @facture_statuts }).sum(:montant_ht)
    @ca_ht_mensuel = current_user.factures.where({ date: @selected_date.beginning_of_month..@selected_date.end_of_month, est_brouillon: false, facture_statut: @facture_statuts }).sum(:montant_ht)
    @graph_ca_ht_mensuel = current_user.factures.where({ est_brouillon: false, facture_statut: @facture_statuts }).group_by_month(:date, format: "%B", range:@selected_date.beginning_of_year..@selected_date.end_of_year).sum(:montant_ht)
  end

end
