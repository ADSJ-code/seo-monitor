require "application_system_test_case"

class TrackedKeywordsTest < ApplicationSystemTestCase
  setup do
    @tracked_keyword = tracked_keywords(:one)
  end

  test "visiting the index" do
    visit tracked_keywords_url
    assert_selector "h1", text: "Tracked keywords"
  end

  test "should create tracked keyword" do
    visit tracked_keywords_url
    click_on "New tracked keyword"

    fill_in "Domain", with: @tracked_keyword.domain
    fill_in "Keyword", with: @tracked_keyword.keyword
    click_on "Create Tracked keyword"

    assert_text "Tracked keyword was successfully created"
    click_on "Back"
  end

  test "should update Tracked keyword" do
    visit tracked_keyword_url(@tracked_keyword)
    click_on "Edit this tracked keyword", match: :first

    fill_in "Domain", with: @tracked_keyword.domain
    fill_in "Keyword", with: @tracked_keyword.keyword
    click_on "Update Tracked keyword"

    assert_text "Tracked keyword was successfully updated"
    click_on "Back"
  end

  test "should destroy Tracked keyword" do
    visit tracked_keyword_url(@tracked_keyword)
    click_on "Destroy this tracked keyword", match: :first

    assert_text "Tracked keyword was successfully destroyed"
  end
end
