require "application_system_test_case"

class DocumentModelesTest < ApplicationSystemTestCase
  setup do
    @document_modele = document_modeles(:one)
  end

  test "visiting the index" do
    visit document_modeles_url
    assert_selector "h1", text: "Document Modeles"
  end

  test "creating a Document modele" do
    visit document_modeles_url
    click_on "New Document Modele"

    fill_in "Coordonnees societe", with: @document_modele.coordonnees_societe
    fill_in "Logo", with: @document_modele.logo
    check "Mention1 active" if @document_modele.mention1_active
    fill_in "Mention1 texte", with: @document_modele.mention1_texte
    check "Mention2 active" if @document_modele.mention2_active
    fill_in "Mention2 texte", with: @document_modele.mention2_texte
    check "Mention3 active" if @document_modele.mention3_active
    fill_in "Mention3 texte", with: @document_modele.mention3_texte
    fill_in "Mention legale", with: @document_modele.mention_legale
    fill_in "Modele", with: @document_modele.modele
    fill_in "Nom", with: @document_modele.nom
    click_on "Create Document modele"

    assert_text "Document modele was successfully created"
    click_on "Back"
  end

  test "updating a Document modele" do
    visit document_modeles_url
    click_on "Edit", match: :first

    fill_in "Coordonnees societe", with: @document_modele.coordonnees_societe
    fill_in "Logo", with: @document_modele.logo
    check "Mention1 active" if @document_modele.mention1_active
    fill_in "Mention1 texte", with: @document_modele.mention1_texte
    check "Mention2 active" if @document_modele.mention2_active
    fill_in "Mention2 texte", with: @document_modele.mention2_texte
    check "Mention3 active" if @document_modele.mention3_active
    fill_in "Mention3 texte", with: @document_modele.mention3_texte
    fill_in "Mention legale", with: @document_modele.mention_legale
    fill_in "Modele", with: @document_modele.modele
    fill_in "Nom", with: @document_modele.nom
    click_on "Update Document modele"

    assert_text "Document modele was successfully updated"
    click_on "Back"
  end

  test "destroying a Document modele" do
    visit document_modeles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Document modele was successfully destroyed"
  end
end
