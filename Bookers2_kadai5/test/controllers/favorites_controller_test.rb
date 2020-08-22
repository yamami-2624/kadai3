require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get creste" do
    get favorites_creste_url
    assert_response :success
  end

  test "should get destoroy" do
    get favorites_destoroy_url
    assert_response :success
  end

end
