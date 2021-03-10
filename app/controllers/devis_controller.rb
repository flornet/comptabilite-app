class DevisController < ApplicationController
  before_action :set_devi, only: %i[ show edit update destroy ]

  # GET /devis or /devis.json
  def index
    @devis = current_user.devis
  end

  # GET /devis/1 or /devis/1.json
  def show
  end

  # GET /devis/new
  def new
    @devi = Devi.new
  end

  # GET /devis/1/edit
  def edit
  end

  # POST /devis or /devis.json
  def create
    @devi = Devi.new(devi_params)
    @devi.user = current_user

    respond_to do |format|
      if @devi.save
        format.html { redirect_to @devi, notice: "Devi was successfully created." }
        format.json { render :show, status: :created, location: @devi }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @devi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /devis/1 or /devis/1.json
  def update
    respond_to do |format|
      if @devi.update(devi_params)
        format.html { redirect_to @devi, notice: "Devi was successfully updated." }
        format.json { render :show, status: :ok, location: @devi }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @devi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devis/1 or /devis/1.json
  def destroy
    @devi.destroy
    respond_to do |format|
      format.html { redirect_to devis_url, notice: "Devi was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_devi
      @devi = Devi.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def devi_params
      params.require(:devi).permit(:type_document, :date, :numero, :designation, :montant_ht, :montant_ttc, :document_modele_id, :pdf, :taxe_id, :devis_statut_id, :client_id)
    end
end
