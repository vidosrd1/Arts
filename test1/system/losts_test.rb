require "application_system_test_case"

class LostsTest < ApplicationSystemTestCase
  setup do
    @lost = losts(:one)
  end

  test "visiting the index" do
    visit losts_url
    assert_selector "h1", text: "Losts"
  end

  test "should create lost" do
    visit losts_url
    click_on "New lost"

    fill_in "Description", with: @lost.description
    check "Pro" if @lost.pro
    fill_in "Thumbnail url", with: @lost.thumbnail_url
    fill_in "Title", with: @lost.title
    fill_in "Video url", with: @lost.video_url
    click_on "Create Lost"

    assert_text "Lost was successfully created"
    click_on "Back"
  end

  test "should update Lost" do
    visit lost_url(@lost)
    click_on "Edit this lost", match: :first

    fill_in "Description", with: @lost.description
    check "Pro" if @lost.pro
    fill_in "Thumbnail url", with: @lost.thumbnail_url
    fill_in "Title", with: @lost.title
    fill_in "Video url", with: @lost.video_url
    click_on "Update Lost"

    assert_text "Lost was successfully updated"
    click_on "Back"
  end

  test "should destroy Lost" do
    visit lost_url(@lost)
    accept_confirm { click_on "Destroy this lost", match: :first }

    assert_text "Lost was successfully destroyed"
  end
end
