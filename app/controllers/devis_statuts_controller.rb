class DevisStatutsController < ApplicationController
  before_action :set_devis_statut, only: %i[ show edit update destroy ]

  # GET /devis_statuts or /devis_statuts.json
  def index
    @devis_statuts = current_user.devis_statuts
  end

  # GET /devis_statuts/1 or /devis_statuts/1.json
  def show
  end

  # GET /devis_statuts/new
  def new
    @devis_statut = DevisStatut.new
  end

  # GET /devis_statuts/1/edit
  def edit
  end

  # POST /devis_statuts or /devis_statuts.json
  def create
    @devis_statut = DevisStatut.new(devis_statut_params)
    @devis_statut.user = current_user

    respond_to do |format|
      if @devis_statut.save
        format.html { redirect_to @devis_statut, notice: "Devis statut was successfully created." }
        format.json { render :show, status: :created, location: @devis_statut }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @devis_statut.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /devis_statuts/1 or /devis_statuts/1.json
  def update
    respond_to do |format|
      if @devis_statut.update(devis_statut_params)
        format.html { redirect_to @devis_statut, notice: "Devis statut was successfully updated." }
        format.json { render :show, status: :ok, location: @devis_statut }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @devis_statut.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devis_statuts/1 or /devis_statuts/1.json
  def destroy
    @devis_statut.destroy
    respond_to do |format|
      format.html { redirect_to devis_statuts_url, notice: "Devis statut was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_devis_statut
      @devis_statut = DevisStatut.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def devis_statut_params
      params.require(:devis_statut).permit(:nom, :defaut)
    end
end
