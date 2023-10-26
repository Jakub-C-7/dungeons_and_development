require "test_helper"

class ActiveQuestsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get active_quests_home_url
    assert_response :success
  end

  test "should get show" do
    get active_quests_show_url
    assert_response :success
  end

  test "should get update" do
    get active_quests_update_url
    assert_response :success
  end

  test "should get search" do
    get active_quests_search_url
    assert_response :success
  end
end
