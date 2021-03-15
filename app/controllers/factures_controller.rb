class FacturesController < ApplicationController
  before_action :set_facture, only: %i[ show edit update destroy ]

  # GET /factures or /factures.json
  def index
    @factures = current_user.factures.order(numero: "DESC")
  end

  # GET /factures/1 or /factures/1.json
  def show
  end

  # GET /factures/new
  def new
    if params[:with_model]
      @modele_selectionne = current_user.document_modeles.find(params[:with_model])
    else
      @modele_selectionne = current_user.document_modeles.where(defaut: true).first
    end
    @facture = Facture.new
    1.times { @facture.facture_lignes.build }
    @facture.client = Client.new
    @facture.facture_statut = current_user.facture_statuts.where(defaut: true).first
    @facture.taxe = current_user.taxes.where(defaut: true).first


    @facture.coordonnees_societe  = @modele_selectionne.coordonnees_societe
    @facture.logo                 = @modele_selectionne.logo
    @facture.contrast_color       = @modele_selectionne.contrast_color
    @facture.date_reglement       = @modele_selectionne.date_reglement
    @facture.mention1_texte       = @modele_selectionne.mention1_texte
    @facture.mention2_texte       = @modele_selectionne.mention2_texte
    @facture.mention3_texte       = @modele_selectionne.mention3_texte
    @facture.mention_legale       = @modele_selectionne.mention_legale

    @facture.user = current_user
    @facture.date = Date.today
    @facture.numero = @facture.generate_new_invoice_number
  end

  # GET /factures/1/edit
  def edit
  end

  # POST /factures or /factures.json
  def create
    @facture = Facture.new(facture_params)
    @facture.user = current_user
    @facture.facture_statut = current_user.facture_statuts.where(defaut: true).first
    if @facture.client
      @facture.client.taxe = @facture.taxe
      @facture.client.user = current_user
    end
    if !est_brouillon?
      @facture.est_brouillon = false
    end

    respond_to do |format|
      if @facture.save
        format.html { redirect_to edit_facture_path(@facture), notice: "Facture was successfully created." }
        format.json { render :show, status: :created, location: @facture }
      else
        if (!@facture.client)
          @facture.client = Client.new
        end
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
        format.html { redirect_to edit_facture_path(@facture), notice: "Facture was successfully updated." }
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
      params[:facture][:client_attributes][:nom] = params[:facture][:client_attributes].delete :client
      params.require(:facture).permit(:type_document, :contrast_color, :date, :designation, :montant_ht, :montant_tva, :montant_ttc, :est_brouillon, :pdf, :taxe_id, :facture_statut_id, :client_id, :coordonnees_societe, :coordonnees_societe, :logo, :date_reglement, :mention1_texte, :mention2_texte, :mention3_texte, :mention_legale, facture_lignes_attributes: [:id, :designation, :montant_ht, :_destroy], client_attributes: [:id, :nom, :adresse, :code_postal, :ville, :pays, :numero_tva_intracommunautaire, :email, :telephone])
    end

    def est_brouillon?
      params[:commit] == "brouillon"
    end
end
