class HomeController < ApplicationController
  def index
    @ca_ht_annuel = current_user.factures.where({ date: Date.today.beginning_of_year..Date.today.end_of_year, est_brouillon: false }).sum(:montant_ht)
    @ca_ht_mensuel = current_user.factures.where({ date: Date.today.beginning_of_month..Date.today.end_of_month, est_brouillon: false }).sum(:montant_ht)
    @graph_ca_ht_mensuel = current_user.factures.where({ est_brouillon: false }).group_by_month(:date, format: "%B", range:Date.today.beginning_of_year..Date.today.end_of_year).sum(:montant_ht)
  end

end
