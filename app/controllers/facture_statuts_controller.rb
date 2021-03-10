class FactureStatutsController < ApplicationController
  before_action :set_facture_statut, only: %i[ show edit update destroy ]

  # GET /facture_statuts or /facture_statuts.json
  def index
    @facture_statuts = current_user.facture_statuts
  end

  # GET /facture_statuts/1 or /facture_statuts/1.json
  def show
  end

  # GET /facture_statuts/new
  def new
    @facture_statut = FactureStatut.new
  end

  # GET /facture_statuts/1/edit
  def edit
  end

  # POST /facture_statuts or /facture_statuts.json
  def create
    @facture_statut = FactureStatut.new(facture_statut_params)
    @facture_statut.user = current_user

    respond_to do |format|
      if @facture_statut.save
        format.html { redirect_to @facture_statut, notice: "Facture statut was successfully created." }
        format.json { render :show, status: :created, location: @facture_statut }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @facture_statut.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facture_statuts/1 or /facture_statuts/1.json
  def update
    respond_to do |format|
      if @facture_statut.update(facture_statut_params)
        format.html { redirect_to @facture_statut, notice: "Facture statut was successfully updated." }
        format.json { render :show, status: :ok, location: @facture_statut }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @facture_statut.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facture_statuts/1 or /facture_statuts/1.json
  def destroy
    @facture_statut.destroy
    respond_to do |format|
      format.html { redirect_to facture_statuts_url, notice: "Facture statut was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facture_statut
      @facture_statut = FactureStatut.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def facture_statut_params
      params.require(:facture_statut).permit(:nom, :defaut)
    end
end
