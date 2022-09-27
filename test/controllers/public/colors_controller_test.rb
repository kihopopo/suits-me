require "test_helper"

class Public::ColorsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_colors_new_url
    assert_response :success
  end

  test "should get index" do
    get public_colors_index_url
    assert_response :success
  end

  test "should get show" do
    get public_colors_show_url
    assert_response :success
  end
end
