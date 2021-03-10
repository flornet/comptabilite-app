json.extract! document_modele, :id, :nom, :coordonnees_societe, :logo, :mention1_texte, :mention1_active, :mention2_texte, :mention2_active, :mention3_texte, :mention3_active, :mention_legale, :modele, :created_at, :updated_at
json.url document_modele_url(document_modele, format: :json)
