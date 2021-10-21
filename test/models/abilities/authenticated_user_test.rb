require "test_helper"

class Ability::AuthenticatedUserTest < ActiveSupport::TestCase
  def setup
    @category = Category.new
    @user = User.new
    @discussion = @category.discussions.build(user: @user)
    @comment = @discussion.comments.build(user: @user, body: "This is a test")
  end

  test "can read all Category" do
    assert Ability.new(@user).can?(:read, @category)
  end

  test "cannot update a Category" do
    refute Ability.new(@user).can?(:update, @category)
  end

  test "cannot delete a Category" do
    refute Ability.new(@user).can?(:delete, @category)
  end

  test "can read all Discussions" do
    assert Ability.new(@user).can?(:read, @discussion)
  end

  test "cannot create a Discussion made by someone else" do
    refute Ability.new(@user_2).can?(:create, @discussion)
  end

  test "can create a Discussion made by themselves" do
    assert Ability.new(@user).can?(:create, @discussion)
  end

  test "can delete their own Discussion" do
    assert Ability.new(@user).can?(:delete, @discussion)
  end

  test "cannot delete a Discussion made by someone else" do
    refute Ability.new(@user_2).can?(:delete, @discussion)
  end

  test "can update their own Discussion" do
    assert Ability.new(@user).can?(:update, @discussion)
  end

  test "cannot update a Discussion made by someone else" do
    refute Ability.new(@user_2).can?(:update, @discussion)
  end

  test "can update their own Comment" do
    assert Ability.new(@user).can?(:update, @comment)
  end

  test "cannot update a Comment made by someone else" do
    refute Ability.new(@user_2).can?(:update, @comment)
  end

  test "can read all Comments" do
    assert Ability.new(@user).can?(:read, @comment)
  end

  test "can create a Comment" do
    assert Ability.new(@user).can?(:create, @comment)
  end

  test "cannot create a Comment on a locked discussion" do
    @discussion.locked = true

    refute Ability.new(@user).can?(:create, @comment)
  end

  test "can delete a Comment" do
    assert Ability.new(@user).can?(:delete, @comment)
  end

  test "cannot delete a Comment made by someone else" do
    refute Ability.new(@user_2).can?(:delete, @comment)
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
end