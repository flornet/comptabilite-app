json.extract! facture_statut, :id, :nom, :couleur, :created_at, :updated_at
json.url facture_statut_url(facture_statut, format: :json)
