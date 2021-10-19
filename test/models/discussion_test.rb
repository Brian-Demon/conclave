require "test_helper"

class DiscussionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @category = Category.new
    @user = User.new
  end

  test "is valid" do
    discussion = Discussion.new(category: @category, user: @user, body: "Test discussion")
    
    assert discussion.valid?
  end

  test "is invalid if no user is present" do
    discussion = Discussion.new(category: @category, user: nil, body: "Test discussion")
    
    refute discussion.valid?
    assert_not_nil discussion.errors[:user], 'no validation error for user present'
  end

  test "is invalid if no Category is present" do
    discussion = Discussion.new(category: nil, user: @user, body: "Test discussion")

    refute discussion.valid?
    assert_not_nil discussion.errors[:category], 'no validation error for category present'
  end

  test "is invalid if no Body is present" do
    discussion = Discussion.new(category: @category, user: @user, body: nil)

    refute discussion.valid?
    assert_not_nil discussion.errors[:body], 'no validation error for body present'
  end
end
