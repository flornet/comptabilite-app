json.extract! facture, :id, :date, :numero, :designation, :montant_ht, :montant_ttc, :pdf, :taxe_id, :facture_statut_id, :client_id, :created_at, :updated_at
json.url facture_url(facture, format: :json)
