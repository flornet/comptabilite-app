class FacturesController < ApplicationController
  before_action :set_facture, only: %i[ show edit update destroy ]
  before_action :set_modele, only: %i[ new create ]
  before_action :set_creating_new, only: %i[ new create ]

  # GET /factures or /factures.json
  def index
    @factures = current_user.factures.order(numero: "DESC")
  end

  # GET /factures/1 or /factures/1.json
  def show
    filename = "Facture #{@facture.numero} - #{@facture.client.nom} - #{montant_pour_pdf(@facture.montant_ttc)}" #Facture 20210203-000119 - MAIF - 11 556,00e
    respond_to do |format|
      format.html
      format.pdf do
        render  show_as_html: params.key?('debug'),
                # save_to_file: Rails.root.join('sauvegardes/factures', "#{filename}.pdf"),
                pdf: filename,
                disposition: 'attachment',
                template: "factures/show.pdf.erb",
                layout: "pdf.html.erb",
                footer:  {
                  font_size: 8,
                  spacing: 20,
                  center: @facture.mention_legale + '

' + 'Page [page] / [topage]'
                },
                margin:  {
                            top: 10,
                            bottom: 30
                          }
      end
    end
  end

  # GET /factures/new
  def new
    @facture = current_user.factures.build_with_model(@modele_selectionne)
  end

  # GET /factures/1/edit
  def edit
    @facture.client = @facture.client_current_version
  end

  # POST /factures or /factures.json
  def create
    @facture = current_user.factures.build_from_create_params(facture_params, est_brouillon?)

    respond_to do |format|
      if @facture.save
        format.html { redirect_to edit_facture_path(@facture), notice: "Facture was successfully created." }
        format.json { render :show, status: :created, location: @facture }
      else
        # if (!@facture.client)
        #   @facture.client = Client.new
        # end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @facture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /factures/1 or /factures/1.json
  def update
    respond_to do |format|
      if @facture.update_from_nested_params(facture_params, est_brouillon?)
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
    def facture_params
      params[:facture][:client_attributes][:nom] = params[:facture][:client_attributes].delete :client
      params.require(:facture).permit(:type_document, :contrast_color, :date, :designation, :montant_ht, :montant_tva, :montant_ttc, :est_brouillon, :pdf, :taxe_id, :facture_statut_id, :client_id, :coordonnees_societe, :coordonnees_societe, :logo, :date_reglement, :mention1_texte, :mention2_texte, :mention3_texte, :mention_legale, facture_lignes_attributes: [:id, :designation, :montant_ht, :_destroy], client_attributes: [:id, :nom, :adresse, :code_postal, :ville, :pays, :numero_tva_intracommunautaire, :email, :telephone])
    end

    def est_brouillon?
      params[:commit] == "brouillon" ? true : false
    end

    def montant_pour_pdf(nombre)
      ActionController::Base.helpers.number_to_currency(nombre, unit: "e", separator: ",", delimiter: " ", format: "%n%u", negative_format: "-%n%u")
    end

end
