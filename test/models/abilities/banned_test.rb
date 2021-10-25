require "test_helper"

class Ability::BannedTest < ActiveSupport::TestCase
  def setup
    @category = Category.new
    @user = User.new(auth_role: "banned")
    @user_2 = User.new
    @discussion = @category.discussions.build(user: @user)
    @comment = @discussion.comments.build(user: @user, body: "This is a test")
  end

  test "cannot create a Category" do
    refute Ability.new(@user).can?(:create, @category)
  end

  test "cannot read a category" do
    refute Ability.new(@user).can?(:read, @category)
  end

  test "cannot create a category" do
    refute Ability.new(@user).can?(:create, @category)
  end

  test "cannot update a category" do
    refute Ability.new(@user).can?(:update, @category)
  end

  test "cannot destroy a category" do
    refute Ability.new(@user).can?(:destroy, @category)
  end

  test "cannot read a discussion" do
    refute Ability.new(@user).can?(:read, @discussion)
  end

  test "cannot create a discussion" do
    refute Ability.new(@user).can?(:create, @discussion)
  end

  test "cannot update a discussion" do
    refute Ability.new(@user).can?(:update, @discussion)
  end

  test "cannot destroy a discussion" do
    refute Ability.new(@user).can?(:destroy, @discussion)
  end

  test "cannot read a comment" do
    refute Ability.new(@user).can?(:read, @comment)
  end

  test "cannot create a comment" do
    refute Ability.new(@user).can?(:create, @comment)
  end

  test "cannot update a comment" do
    refute Ability.new(@user).can?(:update, @comment)
  end

  test "cannot destroy a comment" do
    refute Ability.new(@user).can?(:destroy, @comment)
  end

  test "cannot update role for anyone" do
    refute Ability.new(@user).can?(:update_roles, @user_2)
  end

  test "cannot lock a Discussion" do
    refute Ability.new(@user).can?(:lock, @discussion)
  end

  test "cannot unlock a Discussion" do
    refute Ability.new(@user).can?(:unlock, @discussion)
  end

  test "cannot ban a User" do
    refute Ability.new(@user).can?(:ban, @user_2)
  end

  test "cannot unban a User" do
    refute Ability.new(@user).can?(:unban, @user_2)
  end

  test "cannot pin a Discussion" do
    refute Ability.new(@user).can?(:pin, @discussion)
  end

  test "cannot unpin a Discussion" do
    refute Ability.new(@user).can?(:unpin, @discussion)
  end
end