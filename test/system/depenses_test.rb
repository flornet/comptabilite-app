require "application_system_test_case"

class DepensesTest < ApplicationSystemTestCase
  setup do
    @depense = depenses(:one)
  end

  test "visiting the index" do
    visit depenses_url
    assert_selector "h1", text: "Depenses"
  end

  test "creating a Depense" do
    visit depenses_url
    click_on "New Depense"

    fill_in "Commentaire", with: @depense.commentaire
    fill_in "Date", with: @depense.date
    fill_in "Justificatif data", with: @depense.justificatif_data
    fill_in "Justificatif nom", with: @depense.justificatif_nom
    fill_in "Justificatif type contenu", with: @depense.justificatif_type_contenu
    fill_in "Libelle", with: @depense.libelle
    fill_in "Montant ttc", with: @depense.montant_ttc
    check "Rembourse" if @depense.rembourse
    fill_in "User", with: @depense.user_id
    click_on "Create Depense"

    assert_text "Depense was successfully created"
    click_on "Back"
  end

  test "updating a Depense" do
    visit depenses_url
    click_on "Edit", match: :first

    fill_in "Commentaire", with: @depense.commentaire
    fill_in "Date", with: @depense.date
    fill_in "Justificatif data", with: @depense.justificatif_data
    fill_in "Justificatif nom", with: @depense.justificatif_nom
    fill_in "Justificatif type contenu", with: @depense.justificatif_type_contenu
    fill_in "Libelle", with: @depense.libelle
    fill_in "Montant ttc", with: @depense.montant_ttc
    check "Rembourse" if @depense.rembourse
    fill_in "User", with: @depense.user_id
    click_on "Update Depense"

    assert_text "Depense was successfully updated"
    click_on "Back"
  end

  test "destroying a Depense" do
    visit depenses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Depense was successfully destroyed"
  end
end
