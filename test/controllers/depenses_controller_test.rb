require "test_helper"

class DepensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @depense = depenses(:one)
  end

  test "should get index" do
    get depenses_url
    assert_response :success
  end

  test "should get new" do
    get new_depense_url
    assert_response :success
  end

  test "should create depense" do
    assert_difference('Depense.count') do
      post depenses_url, params: { depense: { commentaire: @depense.commentaire, date: @depense.date, justificatif_data: @depense.justificatif_data, justificatif_nom: @depense.justificatif_nom, justificatif_type_contenu: @depense.justificatif_type_contenu, libelle: @depense.libelle, montant_ttc: @depense.montant_ttc, rembourse: @depense.rembourse, user_id: @depense.user_id } }
    end

    assert_redirected_to depense_url(Depense.last)
  end

  test "should show depense" do
    get depense_url(@depense)
    assert_response :success
  end

  test "should get edit" do
    get edit_depense_url(@depense)
    assert_response :success
  end

  test "should update depense" do
    patch depense_url(@depense), params: { depense: { commentaire: @depense.commentaire, date: @depense.date, justificatif_data: @depense.justificatif_data, justificatif_nom: @depense.justificatif_nom, justificatif_type_contenu: @depense.justificatif_type_contenu, libelle: @depense.libelle, montant_ttc: @depense.montant_ttc, rembourse: @depense.rembourse, user_id: @depense.user_id } }
    assert_redirected_to depense_url(@depense)
  end

  test "should destroy depense" do
    assert_difference('Depense.count', -1) do
      delete depense_url(@depense)
    end

    assert_redirected_to depenses_url
  end
end
