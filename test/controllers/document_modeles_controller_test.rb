require "test_helper"

class DocumentModelesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @document_modele = document_modeles(:one)
  end

  test "should get index" do
    get document_modeles_url
    assert_response :success
  end

  test "should get new" do
    get new_document_modele_url
    assert_response :success
  end

  test "should create document_modele" do
    assert_difference('DocumentModele.count') do
      post document_modeles_url, params: { document_modele: { coordonnees_societe: @document_modele.coordonnees_societe, logo: @document_modele.logo, mention1_active: @document_modele.mention1_active, mention1_texte: @document_modele.mention1_texte, mention2_active: @document_modele.mention2_active, mention2_texte: @document_modele.mention2_texte, mention3_active: @document_modele.mention3_active, mention3_texte: @document_modele.mention3_texte, mention_legale: @document_modele.mention_legale, modele: @document_modele.modele, nom: @document_modele.nom } }
    end

    assert_redirected_to document_modele_url(DocumentModele.last)
  end

  test "should show document_modele" do
    get document_modele_url(@document_modele)
    assert_response :success
  end

  test "should get edit" do
    get edit_document_modele_url(@document_modele)
    assert_response :success
  end

  test "should update document_modele" do
    patch document_modele_url(@document_modele), params: { document_modele: { coordonnees_societe: @document_modele.coordonnees_societe, logo: @document_modele.logo, mention1_active: @document_modele.mention1_active, mention1_texte: @document_modele.mention1_texte, mention2_active: @document_modele.mention2_active, mention2_texte: @document_modele.mention2_texte, mention3_active: @document_modele.mention3_active, mention3_texte: @document_modele.mention3_texte, mention_legale: @document_modele.mention_legale, modele: @document_modele.modele, nom: @document_modele.nom } }
    assert_redirected_to document_modele_url(@document_modele)
  end

  test "should destroy document_modele" do
    assert_difference('DocumentModele.count', -1) do
      delete document_modele_url(@document_modele)
    end

    assert_redirected_to document_modeles_url
  end
end
