class FactureLignesController < ApplicationController
  before_action :set_facture_ligne, only: %i[ show edit update destroy ]

  # GET /facture_lignes or /facture_lignes.json
  def index
    @facture_lignes = FactureLigne.all
  end

  # GET /facture_lignes/1 or /facture_lignes/1.json
  def show
  end

  # GET /facture_lignes/new
  def new
    @facture_ligne = FactureLigne.new
  end

  # GET /facture_lignes/1/edit
  def edit
  end

  # POST /facture_lignes or /facture_lignes.json
  def create
    @facture_ligne = FactureLigne.new(facture_ligne_params)

    respond_to do |format|
      if @facture_ligne.save
        format.html { redirect_to @facture_ligne, notice: "Facture ligne was successfully created." }
        format.json { render :show, status: :created, location: @facture_ligne }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @facture_ligne.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facture_lignes/1 or /facture_lignes/1.json
  def update
    respond_to do |format|
      if @facture_ligne.update(facture_ligne_params)
        format.html { redirect_to @facture_ligne, notice: "Facture ligne was successfully updated." }
        format.json { render :show, status: :ok, location: @facture_ligne }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @facture_ligne.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facture_lignes/1 or /facture_lignes/1.json
  def destroy
    @facture_ligne.destroy
    respond_to do |format|
      format.html { redirect_to facture_lignes_url, notice: "Facture ligne was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facture_ligne
      @facture_ligne = FactureLigne.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def facture_ligne_params
      params.require(:facture_ligne).permit(:facture_id, :designation, :montant_ht)
    end
end
