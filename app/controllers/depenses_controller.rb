class DepensesController < ApplicationController
  before_action :set_depense, only: %i[ show edit update add_attachement remove_attachement destroy ]

  # GET /depenses or /depenses.json
  def index
    @depenses = current_user.depenses.order(date: "DESC", id: "DESC")
    @depense = Depense.new
    @depense.date = Date.today
    @depense.montant_ttc = nil
  end

  # GET /depenses/1 or /depenses/1.json
  def show
    if @depense.has_justificatif
      send_data @depense.justificatif_data, :filename => @depense.justificatif_nom, :type => @depense.justificatif_type_contenu
    else
      redirect_to depenses_url
    end
  end

  # GET /depenses/new
  def new
    redirect_to depenses_url
  end

  # GET /depenses/1/edit
  def edit
    redirect_to depenses_url
  end

  # POST /depenses or /depenses.json
  def create
    @depense = Depense.new(depense_params)
    @depense.user = current_user
    if params[:depense][:justificatif]
        @depense.justificatif = params[:depense][:justificatif]
    end

    respond_to do |format|
      if @depense.save
        format.html { redirect_to depenses_url }
        format.json { render :show, status: :created, location: @depense }
      else
        format.html {
          @depenses = current_user.depenses.order(date: "DESC", id: "DESC")
          render :index, status: :unprocessable_entity
        }
        format.json { render json: @depense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /depenses/1 or /depenses/1.json
  def update
    respond_to do |format|
      if @depense.update(depense_params)
        format.html { redirect_to depenses_url }
        format.json { render :show, status: :ok, location: @depense }
      else
        format.html {
          @depenses = current_user.depenses.order(date: "DESC", id: "DESC")
          render :index, status: :unprocessable_entity
        }
        format.json { render json: @depense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /depenses/1/add_attachement or /depenses/1.json/add_attachement
  def add_attachement
    if params[:depense][:justificatif]
        @depense.justificatif = params[:depense][:justificatif]
    end
    respond_to do |format|
      if @depense.save
        format.html { redirect_to depenses_url }
        format.json { render :show, status: :ok, location: @depense }
      else
        format.html {
          @depenses = current_user.depenses.order(date: "DESC", id: "DESC")
          render :index, status: :unprocessable_entity
        }
        format.json { render json: @depense.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /depenses/1/remove_attachement or /depenses/1.json/remove_attachement
  def remove_attachement
    respond_to do |format|
      @depense.justificatif = nil
      if @depense.save
        format.html { redirect_to depenses_url }
        format.json { render :show, status: :ok, location: @depense }
      else
        format.html {
          @depenses = current_user.depenses.order(date: "DESC", id: "DESC")
          render :index, status: :unprocessable_entity
        }
        format.json { render json: @depense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /depenses/1 or /depenses/1.json
  def destroy
    @depense.destroy
    respond_to do |format|
      format.html { redirect_to depenses_url, notice: "Depense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_depense
      @depense = Depense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def depense_params
      params.require(:depense).permit(:date, :libelle, :commentaire, :montant_ttc, :justificatif, :rembourse)
    end
end
