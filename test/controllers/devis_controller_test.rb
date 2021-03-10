require "test_helper"

class DevisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @devi = devis(:one)
  end

  test "should get index" do
    get devis_url
    assert_response :success
  end

  test "should get new" do
    get new_devi_url
    assert_response :success
  end

  test "should create devi" do
    assert_difference('Devi.count') do
      post devis_url, params: { devi: { client_id: @devi.client_id, date: @devi.date, designation: @devi.designation, devis_statut_id: @devi.devis_statut_id, document_modele_id: @devi.document_modele_id, montant_ht: @devi.montant_ht, montant_ttc: @devi.montant_ttc, numero: @devi.numero, pdf: @devi.pdf, taxe_id: @devi.taxe_id, type: @devi.type } }
    end

    assert_redirected_to devi_url(Devi.last)
  end

  test "should show devi" do
    get devi_url(@devi)
    assert_response :success
  end

  test "should get edit" do
    get edit_devi_url(@devi)
    assert_response :success
  end

  test "should update devi" do
    patch devi_url(@devi), params: { devi: { client_id: @devi.client_id, date: @devi.date, designation: @devi.designation, devis_statut_id: @devi.devis_statut_id, document_modele_id: @devi.document_modele_id, montant_ht: @devi.montant_ht, montant_ttc: @devi.montant_ttc, numero: @devi.numero, pdf: @devi.pdf, taxe_id: @devi.taxe_id, type: @devi.type } }
    assert_redirected_to devi_url(@devi)
  end

  test "should destroy devi" do
    assert_difference('Devi.count', -1) do
      delete devi_url(@devi)
    end

    assert_redirected_to devis_url
  end
end
