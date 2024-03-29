class ClientsController < ApplicationController
  before_action :set_client, only: %i[ show edit update destroy ]

  # GET /clients or /clients.json
  def index
    ## Allowed params 
    # query = nom
    # filter = 1
    # selected_prestations = []
    #
    @params = params
    @selected_prestations = ["1"]
    sql_filter_hash = {
        "1" => "prestation_hypnose", 
        "2" => "prestation_boutique",
        "3" => "prestation_ux",
        "4" => "special"
      }
    sql_filter_array = []
    if (@params[:filter].to_i == 1) 
      if (@params[:selected_prestations] != nil)
        @selected_prestations = @params[:selected_prestations]
      else
        @selected_prestations = ["1", "2", "3", "4"]
      end
    end
      
    @selected_prestations.each do |prestation|
      sql_filter_array.push(sql_filter_hash.values_at(prestation))
    end
    
    if (@params[:filter].to_i == 1) && (@params[:selected_prestations].nil?)
      @selected_prestations = []
      @clients = current_user.clients.where.not(sql_filter_array.join(' OR ')).filtered(query_params).order(:nom)
    else
      @clients = current_user.clients.where(sql_filter_array.join(' OR ')).filtered(query_params).order(:nom)
    end

    # @depenses = current_user.depenses.where('extract(year from date) = ?', @selected_year).order(date: "DESC", id: "DESC")
    
  end

  # GET /clients/1 or /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients or /clients.json
  def create
    @client = Client.new(client_params)
    @client.user = current_user

    respond_to do |format|
      if @client.save
        format.html { redirect_to edit_client_path(@client), notice: "Client was successfully created." }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1 or /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to edit_client_path(@client), notice: "Client was successfully updated." }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1 or /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: "Client was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_params
      params.require(:client).permit(:nom, :adresse, :code_postal, :ville, :pays, :numero_tva_intracommunautaire, :email, :telephone, :taxe_id, :special, :prestation_hypnose, :prestation_boutique, :prestation_ux)
    end

    def query_params
      query_params = params[:query]
      query_params ? query_params.permit(:nom) : {}
    end
end
