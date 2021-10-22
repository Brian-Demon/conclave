require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "is valid" do
    category = Category.new(name: "Test")

    assert category.valid?
  end

  test "is invalid when no name is present" do
    category = Category.new(name: nil)

    refute category.valid?
    assert_not_nil category.errors[:name], "no validation error for name present"
  end
end
