require "test_helper"

class Ability::ModeratorTest < ActiveSupport::TestCase
  def setup
    @category = Category.new
    @user = User.new(auth_role: "moderator")
    @user_2 = User.new
    @discussion = @category.discussions.build(user: @user)
    @discussion2 = @category.discussions.build(user: @user_2)
    @comment = @discussion.comments.build(user: @user, body: "This is a test")
    @comment2 = @discussion2.comments.build(user: @user_2, body: "This is a test")
  end

  test "cannot create a Category" do
    refute Ability.new(@user).can?(:create, @category)
  end

  test "can read all Category" do
    assert Ability.new(@user).can?(:read, @category)
  end

  test "can read all Discussions" do
    assert Ability.new(@user).can?(:read, @discussion)
  end

  test "can create a Discussion made by themselves" do
    assert Ability.new(@user).can?(:create, @discussion)
  end

  test "can delete their own Discussion" do
    assert Ability.new(@user).can?(:delete, @discussion)
  end

  test "can delete a Discussion made by someone else" do
    assert Ability.new(@user).can?(:delete, @discussion2)
  end

  test "can update their own Discussion" do
    assert Ability.new(@user).can?(:update, @discussion)
  end

  test "can update their own Comment" do
    assert Ability.new(@user).can?(:update, @comment)
  end

  test "can read all Comments" do
    assert Ability.new(@user).can?(:read, @comment)
  end

  test "can create a Comment" do
    assert Ability.new(@user).can?(:create, @comment)
  end

  test "can delete a Comment" do
    assert Ability.new(@user).can?(:delete, @comment)
  end

  test "can delete a Comment made by someone else" do
    assert Ability.new(@user).can?(:delete, @comment2)
  end

  test "can lock a Discussion" do
    assert Ability.new(@user).can?(:lock, @discussion)
  end

  test "can unlock a Discussion" do
    assert Ability.new(@user).can?(:unlock, @discussion)
  end

  test "can ban a User" do
    assert Ability.new(@user).can?(:ban, @user_2)
  end

  test "can unban a User" do
    assert Ability.new(@user).can?(:unban, @user_2)
  end

  test "can pin a Discussion" do
    assert Ability.new(@user).can?(:pin, @discussion)
  end

  test "can unpin a Discussion" do
    assert Ability.new(@user).can?(:unpin, @discussion)
  end
end