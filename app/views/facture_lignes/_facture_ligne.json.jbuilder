json.extract! facture_ligne, :id, :facture_id, :designation, :montant_ht, :created_at, :updated_at
json.url facture_ligne_url(facture_ligne, format: :json)
