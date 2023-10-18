require "test_helper"

class TavernControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get tavern_home_url
    assert_response :success
  end
end
