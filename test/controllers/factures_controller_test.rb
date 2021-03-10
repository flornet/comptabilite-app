require "test_helper"

class FacturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @facture = factures(:one)
  end

  test "should get index" do
    get factures_url
    assert_response :success
  end

  test "should get new" do
    get new_facture_url
    assert_response :success
  end

  test "should create facture" do
    assert_difference('Facture.count') do
      post factures_url, params: { facture: { client_id: @facture.client_id, date: @facture.date, designation: @facture.designation, document_modele_id: @facture.document_modele_id, facture_statut_id: @facture.facture_statut_id, montant_ht: @facture.montant_ht, montant_ttc: @facture.montant_ttc, numero: @facture.numero, pdf: @facture.pdf, taxe_id: @facture.taxe_id, type: @facture.type } }
    end

    assert_redirected_to facture_url(Facture.last)
  end

  test "should show facture" do
    get facture_url(@facture)
    assert_response :success
  end

  test "should get edit" do
    get edit_facture_url(@facture)
    assert_response :success
  end

  test "should update facture" do
    patch facture_url(@facture), params: { facture: { client_id: @facture.client_id, date: @facture.date, designation: @facture.designation, document_modele_id: @facture.document_modele_id, facture_statut_id: @facture.facture_statut_id, montant_ht: @facture.montant_ht, montant_ttc: @facture.montant_ttc, numero: @facture.numero, pdf: @facture.pdf, taxe_id: @facture.taxe_id, type: @facture.type } }
    assert_redirected_to facture_url(@facture)
  end

  test "should destroy facture" do
    assert_difference('Facture.count', -1) do
      delete facture_url(@facture)
    end

    assert_redirected_to factures_url
  end
end
