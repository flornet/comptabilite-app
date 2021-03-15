class Client::Filter

  def filter(scope, query_params)
    if query_params[:nom].present?
      scope = scope.where("nom ILIKE :string", string: "%#{query_params[:nom]}%")
    end
    scope
  end

end
