require "application_system_test_case"

class FactureStatutsTest < ApplicationSystemTestCase
  setup do
    @facture_statut = facture_statuts(:one)
  end

  test "visiting the index" do
    visit facture_statuts_url
    assert_selector "h1", text: "Facture Statuts"
  end

  test "creating a Facture statut" do
    visit facture_statuts_url
    click_on "New Facture Statut"

    fill_in "Couleur", with: @facture_statut.couleur
    fill_in "Nom", with: @facture_statut.nom
    click_on "Create Facture statut"

    assert_text "Facture statut was successfully created"
    click_on "Back"
  end

  test "updating a Facture statut" do
    visit facture_statuts_url
    click_on "Edit", match: :first

    fill_in "Couleur", with: @facture_statut.couleur
    fill_in "Nom", with: @facture_statut.nom
    click_on "Update Facture statut"

    assert_text "Facture statut was successfully updated"
    click_on "Back"
  end

  test "destroying a Facture statut" do
    visit facture_statuts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Facture statut was successfully destroyed"
  end
end
