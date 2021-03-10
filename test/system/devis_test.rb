require "application_system_test_case"

class DevisTest < ApplicationSystemTestCase
  setup do
    @devi = devis(:one)
  end

  test "visiting the index" do
    visit devis_url
    assert_selector "h1", text: "Devis"
  end

  test "creating a Devi" do
    visit devis_url
    click_on "New Devi"

    fill_in "Client", with: @devi.client_id
    fill_in "Date", with: @devi.date
    fill_in "Designation", with: @devi.designation
    fill_in "Devis statut", with: @devi.devis_statut_id
    fill_in "Document modele", with: @devi.document_modele_id
    fill_in "Montant ht", with: @devi.montant_ht
    fill_in "Montant ttc", with: @devi.montant_ttc
    fill_in "Numero", with: @devi.numero
    fill_in "Pdf", with: @devi.pdf
    fill_in "Taxe", with: @devi.taxe_id
    fill_in "Type", with: @devi.type
    click_on "Create Devi"

    assert_text "Devi was successfully created"
    click_on "Back"
  end

  test "updating a Devi" do
    visit devis_url
    click_on "Edit", match: :first

    fill_in "Client", with: @devi.client_id
    fill_in "Date", with: @devi.date
    fill_in "Designation", with: @devi.designation
    fill_in "Devis statut", with: @devi.devis_statut_id
    fill_in "Document modele", with: @devi.document_modele_id
    fill_in "Montant ht", with: @devi.montant_ht
    fill_in "Montant ttc", with: @devi.montant_ttc
    fill_in "Numero", with: @devi.numero
    fill_in "Pdf", with: @devi.pdf
    fill_in "Taxe", with: @devi.taxe_id
    fill_in "Type", with: @devi.type
    click_on "Update Devi"

    assert_text "Devi was successfully updated"
    click_on "Back"
  end

  test "destroying a Devi" do
    visit devis_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Devi was successfully destroyed"
  end
end
