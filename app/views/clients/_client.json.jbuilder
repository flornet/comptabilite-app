json.extract! client, :id, :nom, :adresse, :code_postal, :ville, :pays, :numero_tva_intracommunautaire, :email, :telephone, :taxe_id, :created_at, :updated_at
json.url client_url(client, format: :json)
