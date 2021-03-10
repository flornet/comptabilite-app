json.extract! facture, :id, :type, :date, :numero, :designation, :montant_ht, :montant_ttc, :document_modele_id, :pdf, :taxe_id, :facture_statut_id, :client_id, :created_at, :updated_at
json.url facture_url(facture, format: :json)
