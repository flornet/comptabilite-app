json.extract! devis_ligne, :id, :devis_id, :designation, :montant_ht, :created_at, :updated_at
json.url devis_ligne_url(devis_ligne, format: :json)
