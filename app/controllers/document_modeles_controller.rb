class DocumentModelesController < ApplicationController
  before_action :set_document_modele, only: %i[ show edit update destroy ]

  # GET /document_modeles or /document_modeles.json
  def index
    @document_modeles = current_user.document_modeles
  end

  # GET /document_modeles/1 or /document_modeles/1.json
  def show
  end

  # GET /document_modeles/new
  def new
    @document_modele = DocumentModele.new
  end

  # GET /document_modeles/1/edit
  def edit
  end

  # POST /document_modeles or /document_modeles.json
  def create
    @document_modele = DocumentModele.new(document_modele_params)
    @document_modele.user = current_user

    respond_to do |format|
      if @document_modele.save
        format.html { redirect_to @document_modele, notice: "Document modele was successfully created." }
        format.json { render :show, status: :created, location: @document_modele }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @document_modele.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /document_modeles/1 or /document_modeles/1.json
  def update
    respond_to do |format|
      if @document_modele.update(document_modele_params)
        format.html { redirect_to @document_modele, notice: "Document modele was successfully updated." }
        format.json { render :show, status: :ok, location: @document_modele }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @document_modele.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /document_modeles/1 or /document_modeles/1.json
  def destroy
    @document_modele.destroy
    respond_to do |format|
      format.html { redirect_to document_modeles_url, notice: "Document modele was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document_modele
      @document_modele = DocumentModele.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def document_modele_params
      params.require(:document_modele).permit(:nom, :coordonnees_societe, :logo, :mention1_texte, :mention1_active, :mention2_texte, :mention2_active, :mention3_texte, :mention3_active, :mention_legale, :modele)
    end
end
