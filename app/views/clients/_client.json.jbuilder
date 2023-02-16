json.extract! client, :id, :nom, :adresse, :code_postal, :ville, :pays, :numero_tva_intracommunautaire, :email, :telephone, :taxe_id, :special, :prestation_hypnose, :prestation_boutique, :prestation_ux, :created_at, :updated_at
json.url client_url(client, format: :json)
