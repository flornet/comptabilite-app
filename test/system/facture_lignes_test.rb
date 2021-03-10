require "application_system_test_case"

class FactureLignesTest < ApplicationSystemTestCase
  setup do
    @facture_ligne = facture_lignes(:one)
  end

  test "visiting the index" do
    visit facture_lignes_url
    assert_selector "h1", text: "Facture Lignes"
  end

  test "creating a Facture ligne" do
    visit facture_lignes_url
    click_on "New Facture Ligne"

    fill_in "Designation", with: @facture_ligne.designation
    fill_in "Facture", with: @facture_ligne.facture_id
    fill_in "Montant ht", with: @facture_ligne.montant_ht
    click_on "Create Facture ligne"

    assert_text "Facture ligne was successfully created"
    click_on "Back"
  end

  test "updating a Facture ligne" do
    visit facture_lignes_url
    click_on "Edit", match: :first

    fill_in "Designation", with: @facture_ligne.designation
    fill_in "Facture", with: @facture_ligne.facture_id
    fill_in "Montant ht", with: @facture_ligne.montant_ht
    click_on "Update Facture ligne"

    assert_text "Facture ligne was successfully updated"
    click_on "Back"
  end

  test "destroying a Facture ligne" do
    visit facture_lignes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Facture ligne was successfully destroyed"
  end
end
