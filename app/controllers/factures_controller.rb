class FacturesController < ApplicationController
  before_action :set_facture, only: %i[ show edit update destroy ]

  # GET /factures or /factures.json
  def index
    @factures = current_user.factures
  end

  # GET /factures/1 or /factures/1.json
  def show
  end

  # GET /factures/new
  def new
    @facture = Facture.new
    1.times { @facture.facture_lignes.build }
    @facture.client = Client.new
  end

  # GET /factures/1/edit
  def edit
  end

  # POST /factures or /factures.json
  def create
    @facture = Facture.new(facture_params)
    @facture.user = current_user
    @facture.client.taxe = @facture.taxe

    respond_to do |format|
      if @facture.save
        format.html { redirect_to @facture, notice: "Facture was successfully created." }
        format.json { render :show, status: :created, location: @facture }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @facture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /factures/1 or /factures/1.json
  def update
    respond_to do |format|
      if @facture.update(facture_params)
        format.html { redirect_to @facture, notice: "Facture was successfully updated." }
        format.json { render :show, status: :ok, location: @facture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @facture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /factures/1 or /factures/1.json
  def destroy
    @facture.destroy
    respond_to do |format|
      format.html { redirect_to factures_url, notice: "Facture was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facture
      @facture = Facture.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def facture_params
      params.require(:facture).permit(:type_document, :date, :numero, :designation, :montant_ht, :montant_ttc, :document_modele_id, :pdf, :taxe_id, :facture_statut_id, :client_id, facture_lignes_attributes: [:designation, :montant_ht, :_destroy], client_attributes: [:nom, :adresse, :code_postal, :ville, :pays, :numero_tva_intracommunautaire, :email, :telephone])
    end
end
