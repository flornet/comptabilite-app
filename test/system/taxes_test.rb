require "application_system_test_case"

class TaxesTest < ApplicationSystemTestCase
  setup do
    @tax = taxes(:one)
  end

  test "visiting the index" do
    visit taxes_url
    assert_selector "h1", text: "Taxes"
  end

  test "creating a Taxe" do
    visit taxes_url
    click_on "New Taxe"

    fill_in "Nom", with: @tax.nom
    fill_in "Taux", with: @tax.taux
    click_on "Create Taxe"

    assert_text "Taxe was successfully created"
    click_on "Back"
  end

  test "updating a Taxe" do
    visit taxes_url
    click_on "Edit", match: :first

    fill_in "Nom", with: @tax.nom
    fill_in "Taux", with: @tax.taux
    click_on "Update Taxe"

    assert_text "Taxe was successfully updated"
    click_on "Back"
  end

  test "destroying a Taxe" do
    visit taxes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Taxe was successfully destroyed"
  end
end
