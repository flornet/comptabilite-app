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
    @facture.coordonnees_societe = current_user.document_modeles.first.coordonnees_societe
  end

  # GET /factures/1/edit
  def edit
  end

  # POST /factures or /factures.json
  def create
    @facture = Facture.new(facture_params)
    @facture.user = current_user
    if @facture.client
      @facture.client.taxe = @facture.taxe
      @facture.client.user = current_user
    end
    if !est_brouillon?
      @facture.est_brouillon = false
    end

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
    if !est_brouillon?
      @facture.est_brouillon = false
    end
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
      params.require(:facture).permit(:type_document, :date, :numero, :designation, :montant_ht, :montant_ttc, :est_brouillon, :pdf, :taxe_id, :facture_statut_id, :client_id, :coordonnees_societe, :coordonnees_societe, :logo, :mention1_texte, :mention1_active, :mention2_texte, :mention2_active, :mention3_texte, :mention3_active, :mention_legale, facture_lignes_attributes: [:id, :designation, :montant_ht, :_destroy], client_attributes: [:id, :nom, :adresse, :code_postal, :ville, :pays, :numero_tva_intracommunautaire, :email, :telephone])
    end

    def est_brouillon?
      params[:commit] == "brouillon"
    end
end
