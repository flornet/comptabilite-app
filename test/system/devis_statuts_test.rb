require "application_system_test_case"

class DevisStatutsTest < ApplicationSystemTestCase
  setup do
    @devis_statut = devis_statuts(:one)
  end

  test "visiting the index" do
    visit devis_statuts_url
    assert_selector "h1", text: "Devis Statuts"
  end

  test "creating a Devis statut" do
    visit devis_statuts_url
    click_on "New Devis Statut"

    fill_in "Couleur", with: @devis_statut.couleur
    fill_in "Nom", with: @devis_statut.nom
    click_on "Create Devis statut"

    assert_text "Devis statut was successfully created"
    click_on "Back"
  end

  test "updating a Devis statut" do
    visit devis_statuts_url
    click_on "Edit", match: :first

    fill_in "Couleur", with: @devis_statut.couleur
    fill_in "Nom", with: @devis_statut.nom
    click_on "Update Devis statut"

    assert_text "Devis statut was successfully updated"
    click_on "Back"
  end

  test "destroying a Devis statut" do
    visit devis_statuts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Devis statut was successfully destroyed"
  end
end
