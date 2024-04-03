require 'rubygems'
require 'zip'
require 'csv'

class DepensesController < ApplicationController
  before_action :set_depense, only: %i[ show edit update destroy destroy_attachement ]

  # GET /depenses or /depenses.json
  def index
    @params = params
    @selected_year = Date.today.year.to_i
    if (params[:selected_year] != nil)
      @selected_year = params[:selected_year].to_i
    end

    @depenses = current_user.depenses.where('extract(year from date) = ?', @selected_year).order(date: "DESC", id: "DESC")

    respond_to do |format|
      format.html do 
        @depense = Depense.new
        @depense.date = Date.today
        @depense.montant_ttc = nil
      end
      
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = "attachment; filename=#{@selected_year} - Dépenses.csv"
        render template: "depenses/export"
      end
      
      format.zip do
        file_name = "#{@selected_year} - Justificatifs.zip"
        zip_file = Tempfile.new(file_name)
        Zip::OutputStream.open(zip_file.path) do |zos|
          @depenses.each do |depense|
            if depense.has_justificatif
              zos.put_next_entry(depense.justificatif_nom)
              zos.puts depense.justificatif_data
            end
          end
        end

       zip_data = File.read(zip_file.path)
       zip_file.close
       zip_file.unlink
       send_data zip_data, :filename => file_name
      end
    end
    #
    # if ((params[:form_action]) && params[:form_action] == "exporter_table")
    #
    # elsif ((params[:form_action]) && params[:form_action] == "exporter_justificatifs")
    #
    # else
    #
    # end
  end

  # GET /depenses/1 or /depenses/1.json
  def show
    if @depense.has_justificatif
      send_data @depense.justificatif_data, :filename => @depense.justificatif_nom, :type => @depense.justificatif_type_contenu, :disposition => "inline"
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

  # DELETE /depenses/1 or /depenses/1.json
  def destroy
    @depense.destroy
    respond_to do |format|
      format.html { redirect_to depenses_url, notice: "Depense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /depenses/1/destroy_attachement or /depenses/1.json/destroy_attachement
  def destroy_attachement
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
