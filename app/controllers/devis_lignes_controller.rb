class DevisLignesController < ApplicationController
  before_action :set_devis_ligne, only: %i[ show edit update destroy ]

  # GET /devis_lignes or /devis_lignes.json
  def index
    @devis_lignes = DevisLigne.all
  end

  # GET /devis_lignes/1 or /devis_lignes/1.json
  def show
  end

  # GET /devis_lignes/new
  def new
    @devis_ligne = DevisLigne.new
  end

  # GET /devis_lignes/1/edit
  def edit
  end

  # POST /devis_lignes or /devis_lignes.json
  def create
    @devis_ligne = DevisLigne.new(devis_ligne_params)

    respond_to do |format|
      if @devis_ligne.save
        format.html { redirect_to @devis_ligne, notice: "Devis ligne was successfully created." }
        format.json { render :show, status: :created, location: @devis_ligne }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @devis_ligne.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /devis_lignes/1 or /devis_lignes/1.json
  def update
    respond_to do |format|
      if @devis_ligne.update(devis_ligne_params)
        format.html { redirect_to @devis_ligne, notice: "Devis ligne was successfully updated." }
        format.json { render :show, status: :ok, location: @devis_ligne }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @devis_ligne.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devis_lignes/1 or /devis_lignes/1.json
  def destroy
    @devis_ligne.destroy
    respond_to do |format|
      format.html { redirect_to devis_lignes_url, notice: "Devis ligne was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_devis_ligne
      @devis_ligne = DevisLigne.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def devis_ligne_params
      params.require(:devis_ligne).permit(:devis_id, :designation, :montant_ht)
    end
end
