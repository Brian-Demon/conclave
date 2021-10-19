require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "get index returns success" do
    get categories_path
    assert_response :success
  end
end
