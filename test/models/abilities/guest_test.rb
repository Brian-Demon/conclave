require "test_helper"

class Ability::GuestTest < ActiveSupport::TestCase
  def setup
    @category = Category.new
    @user = User.new
    @user_2 = User.new
    @discussion = @category.discussions.build(user: @user)
    @comment = @discussion.comments.build(user: @user, body: "This is a test")
  end

  test "can read all Category" do
    assert Ability.new(nil).can?(:read, @category)
  end

  test "can read all Discussions" do
    assert Ability.new(nil).can?(:read, @discussion)
  end

  test "cannot create a Discussion" do
    refute Ability.new(nil).can?(:create, @discussion)
  end

  test "cannot delete a Discussion made by someone else" do
    refute Ability.new(nil).can?(:delete, @discussion)
  end

  test "cannot update a Discussion" do
    refute Ability.new(nil).can?(:update, @discussion)
  end

  test "cannot update a Comment" do
    refute Ability.new(nil).can?(:update, @comment)
  end

  test "can read all Comments" do
    assert Ability.new(nil).can?(:read, @comment)
  end

  test "cannot create a Comment" do
    refute Ability.new(nil).can?(:create, @comment)
  end

  test "cannot delete a Comment" do
    refute Ability.new(nil).can?(:delete, @comment)
  end

  test "cannot update role for anyone" do
    refute Ability.new(nil).can?(:update_roles, @user_2)
  end

  test "cannot lock a Discussion" do
    refute Ability.new(@user).can?(:lock, @discussion)
  end
end
