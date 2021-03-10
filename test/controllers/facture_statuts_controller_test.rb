require "test_helper"

class FactureStatutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @facture_statut = facture_statuts(:one)
  end

  test "should get index" do
    get facture_statuts_url
    assert_response :success
  end

  test "should get new" do
    get new_facture_statut_url
    assert_response :success
  end

  test "should create facture_statut" do
    assert_difference('FactureStatut.count') do
      post facture_statuts_url, params: { facture_statut: { couleur: @facture_statut.couleur, nom: @facture_statut.nom } }
    end

    assert_redirected_to facture_statut_url(FactureStatut.last)
  end

  test "should show facture_statut" do
    get facture_statut_url(@facture_statut)
    assert_response :success
  end

  test "should get edit" do
    get edit_facture_statut_url(@facture_statut)
    assert_response :success
  end

  test "should update facture_statut" do
    patch facture_statut_url(@facture_statut), params: { facture_statut: { couleur: @facture_statut.couleur, nom: @facture_statut.nom } }
    assert_redirected_to facture_statut_url(@facture_statut)
  end

  test "should destroy facture_statut" do
    assert_difference('FactureStatut.count', -1) do
      delete facture_statut_url(@facture_statut)
    end

    assert_redirected_to facture_statuts_url
  end
end
