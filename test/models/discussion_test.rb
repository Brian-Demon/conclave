require "test_helper"

class DiscussionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @category = Category.new(name: "Important Stuff")
    @user = User.new
  end

  def teardown
    Category.destroy_all
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

  test "lock sets locked to true" do
    discussion = Discussion.new(category: @category, user: @user, body: nil)
    refute discussion.locked

    discussion.lock
    assert discussion.locked
  end

  test "unlock sets locked to false" do
    discussion = Discussion.new(category: @category, user: @user, body: nil, locked: true)
    assert discussion.locked

    discussion.unlock
    refute discussion.locked
  end

  test "pin sets pinned to true" do
    discussion = Discussion.new(category: @category, user: @user, body: nil, pinned: false)
    refute discussion.pinned

    discussion.pin
    assert discussion.pinned
  end

  test "unpin sets pinned to false" do
    discussion = Discussion.new(category: @category, user: @user, body: nil, pinned: true)
    assert discussion.pinned

    discussion.unpin
    refute discussion.pinned
  end

  test "pinned scope returns only pinned Discussions" do
    @category.save
    @user.save
    discussion_pinned = Discussion.create!(category: @category, user: @user, body: "Important Stuff in here", pinned: true)
    discussion_unpinned = Discussion.create!(category: @category, user: @user, body: "lol memes", pinned: false)

    assert_equal [discussion_pinned], Discussion.pinned.all.to_a
  end

  test "unpinned scope returns only unpinned Discussions" do
    @category.save
    @user.save
    discussion_pinned = Discussion.create!(category: @category, user: @user, body: "Important Stuff in here", pinned: true)
    discussion_unpinned = Discussion.create!(category: @category, user: @user, body: "lol memes", pinned: false)

    assert_equal [discussion_unpinned], Discussion.unpinned.all.to_a
  end
end
