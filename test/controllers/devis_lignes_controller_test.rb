require "test_helper"

class DevisLignesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @devis_ligne = devis_lignes(:one)
  end

  test "should get index" do
    get devis_lignes_url
    assert_response :success
  end

  test "should get new" do
    get new_devis_ligne_url
    assert_response :success
  end

  test "should create devis_ligne" do
    assert_difference('DevisLigne.count') do
      post devis_lignes_url, params: { devis_ligne: { designation: @devis_ligne.designation, devis_id: @devis_ligne.devis_id, montant_ht: @devis_ligne.montant_ht } }
    end

    assert_redirected_to devis_ligne_url(DevisLigne.last)
  end

  test "should show devis_ligne" do
    get devis_ligne_url(@devis_ligne)
    assert_response :success
  end

  test "should get edit" do
    get edit_devis_ligne_url(@devis_ligne)
    assert_response :success
  end

  test "should update devis_ligne" do
    patch devis_ligne_url(@devis_ligne), params: { devis_ligne: { designation: @devis_ligne.designation, devis_id: @devis_ligne.devis_id, montant_ht: @devis_ligne.montant_ht } }
    assert_redirected_to devis_ligne_url(@devis_ligne)
  end

  test "should destroy devis_ligne" do
    assert_difference('DevisLigne.count', -1) do
      delete devis_ligne_url(@devis_ligne)
    end

    assert_redirected_to devis_lignes_url
  end
end
