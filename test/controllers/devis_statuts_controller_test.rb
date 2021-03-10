require "test_helper"

class DevisStatutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @devis_statut = devis_statuts(:one)
  end

  test "should get index" do
    get devis_statuts_url
    assert_response :success
  end

  test "should get new" do
    get new_devis_statut_url
    assert_response :success
  end

  test "should create devis_statut" do
    assert_difference('DevisStatut.count') do
      post devis_statuts_url, params: { devis_statut: { couleur: @devis_statut.couleur, nom: @devis_statut.nom } }
    end

    assert_redirected_to devis_statut_url(DevisStatut.last)
  end

  test "should show devis_statut" do
    get devis_statut_url(@devis_statut)
    assert_response :success
  end

  test "should get edit" do
    get edit_devis_statut_url(@devis_statut)
    assert_response :success
  end

  test "should update devis_statut" do
    patch devis_statut_url(@devis_statut), params: { devis_statut: { couleur: @devis_statut.couleur, nom: @devis_statut.nom } }
    assert_redirected_to devis_statut_url(@devis_statut)
  end

  test "should destroy devis_statut" do
    assert_difference('DevisStatut.count', -1) do
      delete devis_statut_url(@devis_statut)
    end

    assert_redirected_to devis_statuts_url
  end
end
