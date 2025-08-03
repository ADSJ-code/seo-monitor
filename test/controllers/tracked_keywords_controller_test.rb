require "test_helper"

class TrackedKeywordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tracked_keyword = tracked_keywords(:one)
  end

  test "should get index" do
    get tracked_keywords_url
    assert_response :success
  end

  test "should get new" do
    get new_tracked_keyword_url
    assert_response :success
  end

  test "should create tracked_keyword" do
    assert_difference("TrackedKeyword.count") do
      post tracked_keywords_url, params: { tracked_keyword: { domain: @tracked_keyword.domain, keyword: @tracked_keyword.keyword } }
    end

    assert_redirected_to tracked_keyword_url(TrackedKeyword.last)
  end

  test "should show tracked_keyword" do
    get tracked_keyword_url(@tracked_keyword)
    assert_response :success
  end

  test "should get edit" do
    get edit_tracked_keyword_url(@tracked_keyword)
    assert_response :success
  end

  test "should update tracked_keyword" do
    patch tracked_keyword_url(@tracked_keyword), params: { tracked_keyword: { domain: @tracked_keyword.domain, keyword: @tracked_keyword.keyword } }
    assert_redirected_to tracked_keyword_url(@tracked_keyword)
  end

  test "should destroy tracked_keyword" do
    assert_difference("TrackedKeyword.count", -1) do
      delete tracked_keyword_url(@tracked_keyword)
    end

    assert_redirected_to tracked_keywords_url
  end
end
