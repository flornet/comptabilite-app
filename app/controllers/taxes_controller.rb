class TaxesController < ApplicationController
  before_action :set_tax, only: %i[ show edit update destroy ]

  # GET /taxes or /taxes.json
  def index
    @taxes = current_user.taxes
  end

  # GET /taxes/1 or /taxes/1.json
  def show
  end

  # GET /taxes/new
  def new
    @tax = Taxe.new
  end

  # GET /taxes/1/edit
  def edit
  end

  # POST /taxes or /taxes.json
  def create
    @tax = Taxe.new(tax_params)
    @tax.user = current_user

    respond_to do |format|
      if @tax.save
        format.html { redirect_to @tax, notice: "Taxe was successfully created." }
        format.json { render :show, status: :created, location: @tax }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tax.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /taxes/1 or /taxes/1.json
  def update
    respond_to do |format|
      if @tax.update(tax_params)
        format.html { redirect_to @tax, notice: "Taxe was successfully updated." }
        format.json { render :show, status: :ok, location: @tax }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tax.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /taxes/1 or /taxes/1.json
  def destroy
    @tax.destroy
    respond_to do |format|
      format.html { redirect_to taxes_url, notice: "Taxe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tax
      @tax = Taxe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tax_params
      params.require(:taxe).permit(:nom, :taux, :defaut)
    end
end
