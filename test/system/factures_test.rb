require "application_system_test_case"

class FacturesTest < ApplicationSystemTestCase
  setup do
    @facture = factures(:one)
  end

  test "visiting the index" do
    visit factures_url
    assert_selector "h1", text: "Factures"
  end

  test "creating a Facture" do
    visit factures_url
    click_on "New Facture"

    fill_in "Client", with: @facture.client_id
    fill_in "Date", with: @facture.date
    fill_in "Designation", with: @facture.designation
    fill_in "Document modele", with: @facture.document_modele_id
    fill_in "Facture statut", with: @facture.facture_statut_id
    fill_in "Montant ht", with: @facture.montant_ht
    fill_in "Montant ttc", with: @facture.montant_ttc
    fill_in "Numero", with: @facture.numero
    fill_in "Pdf", with: @facture.pdf
    fill_in "Taxe", with: @facture.taxe_id
    fill_in "Type", with: @facture.type
    click_on "Create Facture"

    assert_text "Facture was successfully created"
    click_on "Back"
  end

  test "updating a Facture" do
    visit factures_url
    click_on "Edit", match: :first

    fill_in "Client", with: @facture.client_id
    fill_in "Date", with: @facture.date
    fill_in "Designation", with: @facture.designation
    fill_in "Document modele", with: @facture.document_modele_id
    fill_in "Facture statut", with: @facture.facture_statut_id
    fill_in "Montant ht", with: @facture.montant_ht
    fill_in "Montant ttc", with: @facture.montant_ttc
    fill_in "Numero", with: @facture.numero
    fill_in "Pdf", with: @facture.pdf
    fill_in "Taxe", with: @facture.taxe_id
    fill_in "Type", with: @facture.type
    click_on "Update Facture"

    assert_text "Facture was successfully updated"
    click_on "Back"
  end

  test "destroying a Facture" do
    visit factures_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Facture was successfully destroyed"
  end
end
