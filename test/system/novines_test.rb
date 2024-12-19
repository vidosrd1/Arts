require "application_system_test_case"

class NovinesTest < ApplicationSystemTestCase
  setup do
    @novine = novines(:one)
  end

  test "visiting the index" do
    visit novines_url
    assert_selector "h1", text: "Novines"
  end

  test "should create novine" do
    visit novines_url
    click_on "New novine"

    fill_in "Name", with: @novine.name
    fill_in "Publish", with: @novine.publish
    fill_in "Title", with: @novine.title
    fill_in "User", with: @novine.user_id
    click_on "Create Novine"

    assert_text "Novine was successfully created"
    click_on "Back"
  end

  test "should update Novine" do
    visit novine_url(@novine)
    click_on "Edit this novine", match: :first

    fill_in "Name", with: @novine.name
    fill_in "Publish", with: @novine.publish
    fill_in "Title", with: @novine.title
    fill_in "User", with: @novine.user_id
    click_on "Update Novine"

    assert_text "Novine was successfully updated"
    click_on "Back"
  end

  test "should destroy Novine" do
    visit novine_url(@novine)
    click_on "Destroy this novine", match: :first

    assert_text "Novine was successfully destroyed"
  end
end
