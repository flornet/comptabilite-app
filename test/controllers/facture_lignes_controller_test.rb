require "test_helper"

class FactureLignesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @facture_ligne = facture_lignes(:one)
  end

  test "should get index" do
    get facture_lignes_url
    assert_response :success
  end

  test "should get new" do
    get new_facture_ligne_url
    assert_response :success
  end

  test "should create facture_ligne" do
    assert_difference('FactureLigne.count') do
      post facture_lignes_url, params: { facture_ligne: { designation: @facture_ligne.designation, facture_id: @facture_ligne.facture_id, montant_ht: @facture_ligne.montant_ht } }
    end

    assert_redirected_to facture_ligne_url(FactureLigne.last)
  end

  test "should show facture_ligne" do
    get facture_ligne_url(@facture_ligne)
    assert_response :success
  end

  test "should get edit" do
    get edit_facture_ligne_url(@facture_ligne)
    assert_response :success
  end

  test "should update facture_ligne" do
    patch facture_ligne_url(@facture_ligne), params: { facture_ligne: { designation: @facture_ligne.designation, facture_id: @facture_ligne.facture_id, montant_ht: @facture_ligne.montant_ht } }
    assert_redirected_to facture_ligne_url(@facture_ligne)
  end

  test "should destroy facture_ligne" do
    assert_difference('FactureLigne.count', -1) do
      delete facture_ligne_url(@facture_ligne)
    end

    assert_redirected_to facture_lignes_url
  end
end
