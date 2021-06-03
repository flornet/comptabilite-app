json.extract! depense, :id, :date, :libelle, :commentaire, :montant_ttc, :justificatif_nom, :justificatif_type_contenu, :justificatif_data, :rembourse, :user_id, :created_at, :updated_at
json.url depense_url(depense, format: :json)
