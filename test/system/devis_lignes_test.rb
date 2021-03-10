require "application_system_test_case"

class DevisLignesTest < ApplicationSystemTestCase
  setup do
    @devis_ligne = devis_lignes(:one)
  end

  test "visiting the index" do
    visit devis_lignes_url
    assert_selector "h1", text: "Devis Lignes"
  end

  test "creating a Devis ligne" do
    visit devis_lignes_url
    click_on "New Devis Ligne"

    fill_in "Designation", with: @devis_ligne.designation
    fill_in "Devis", with: @devis_ligne.devis_id
    fill_in "Montant ht", with: @devis_ligne.montant_ht
    click_on "Create Devis ligne"

    assert_text "Devis ligne was successfully created"
    click_on "Back"
  end

  test "updating a Devis ligne" do
    visit devis_lignes_url
    click_on "Edit", match: :first

    fill_in "Designation", with: @devis_ligne.designation
    fill_in "Devis", with: @devis_ligne.devis_id
    fill_in "Montant ht", with: @devis_ligne.montant_ht
    click_on "Update Devis ligne"

    assert_text "Devis ligne was successfully updated"
    click_on "Back"
  end

  test "destroying a Devis ligne" do
    visit devis_lignes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Devis ligne was successfully destroyed"
  end
end
