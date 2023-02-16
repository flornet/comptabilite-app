class DevisController < ApplicationController
  before_action :set_devi, only: %i[ show edit update destroy ]
  before_action :set_modele, only: %i[ new create ]
  before_action :set_creating_new, only: %i[ new create duplicate ]

  # GET /devis or /devis.json
  def index
    @devis = current_user.devis.order(date: "DESC", numero: "DESC")
  end

  # GET /devis/1 or /devis/1.json
  def show
    filename = "Devis #{@devi.numero} - #{@devi.client.nom} - #{montant_pour_pdf(@devi.montant_ttc)}" #Devis 20210203-000119 - MAIF - 11 556,00e
    respond_to do |format|
      format.html
      format.pdf do
        render  show_as_html: params.key?('debug'),
                # save_to_file: Rails.root.join('sauvegardes/factures', "#{filename}.pdf"),
                pdf: filename,
                disposition: 'attachment',
                template: "devis/show.pdf.erb",
                layout: "pdf.html.erb",
                footer:  {
                  font_size: 8,
                  spacing: 20,
                  center: @devi.mention_legale + '

' + 'Page [page] / [topage]'
                },
                margin:  {
                            top: 10,
                            bottom: 30
                          }
      end
    end
  end

  # GET /devis/new
  def new
    @devi = current_user.devis.build_with_model(@modele_selectionne)
  end

  # GET /devis/1/edit
  def edit
    @devi.client = @devi.client_current_version
  end

  # POST /devis or /devis.json
  def create
    @devi = current_user.devis.build_from_create_params(devi_params)

    respond_to do |format|
      if @devi.save
        format.html { redirect_to edit_devi_path(@devi) }
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
      if @devi.update_from_nested_params(devi_params)
        format.html { redirect_to edit_devi_path(@devi) }
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
      format.html { redirect_to devis_url }
      format.json { head :no_content }
    end
  end

  # GET /devis/1/duplicate or /devis/1.json/duplicate
  def duplicate
    @devis_source = Devi.find(params[:id])
    @devi = @devis_source.duplicate

    respond_to do |format|
      format.html { render :new }
      format.json { render json: @devi.errors, status: :unprocessable_entity }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_devi
      @devi = Devi.find(params[:id])
    end

    def set_modele
      if params[:with_model]
        @modele_selectionne = current_user.document_modeles.find(params[:with_model])
      else
        @modele_selectionne = current_user.document_modeles.where(defaut: true).first
      end
    end

    def set_creating_new
      @creating_new = true
    end

    # Only allow a list of trusted parameters through.
    def devi_params
      params[:devi][:client_attributes][:nom] = params[:devi][:client_attributes].delete :client unless params[:devi][:client_attributes].nil?
      params.require(:devi).permit(:type_document, :contrast_color, :date, :designation, :montant_ht, :montant_tva, :montant_ttc, :est_brouillon, :pdf, :taxe_id, :devis_statut_id, :client_id, :coordonnees_societe, :coordonnees_societe, :logo, :date_validite, :mention1_texte, :mention2_texte, :mention3_texte, :mention_legale, devis_lignes_attributes: [:id, :designation, :montant_ht, :_destroy], client_attributes: [:id, :nom, :adresse, :code_postal, :ville, :pays, :numero_tva_intracommunautaire, :email, :telephone, :special, :prestation_hypnose, :prestation_boutique, :prestation_ux])
    end

    def montant_pour_pdf(nombre)
      ActionController::Base.helpers.number_to_currency(nombre, unit: "e", separator: ",", delimiter: " ", format: "%n%u", negative_format: "-%n%u")
    end
end
