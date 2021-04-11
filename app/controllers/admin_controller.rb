class AdminController < ApplicationController

  before_action :set_user, only: %i[ index edit update ]

  def index
  end

  def edit
  end

  # PATCH/PUT /admin/update or /admin/update.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_index_path(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_user
      @user = current_user
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:code_naf_ape, :numero_tva, :numero_siren, :numero_siret, :dernier_numero_facture, :dernier_numero_devis)
    end

end
