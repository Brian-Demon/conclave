require "test_helper"

class AbilityTest < ActiveSupport::TestCase
  def setup
    @category = Category.new
    @user = User.new
    @user_2 = User.new
    @discussion = @category.discussions.build(user: @user)
    @comment = @discussion.comments.build(user: @user, body: "This is a test")
  end

  test "authenticated user can read all Category" do
    assert Ability.new(@user).can?(:read, @category)
  end

  test "authenticated user can read all Discussions" do
    assert Ability.new(@user).can?(:read, @discussion)
  end

  test "authenticated user cannot create a Discussion made by someone else" do
    refute Ability.new(@user_2).can?(:create, @discussion)
  end

  test "authenticated user can create a Discussion made by themselves" do
    assert Ability.new(@user).can?(:create, @discussion)
  end

  test "authenticated user can delete their own Discussion" do
    assert Ability.new(@user).can?(:delete, @discussion)
  end

  test "authenticated user cannot delete a Discussion made by someone else" do
    refute Ability.new(@user_2).can?(:delete, @discussion)
  end

  test "authenticated user can update their own Discussion" do
    assert Ability.new(@user).can?(:update, @discussion)
  end

  test "authenticated user cannot update a Discussion made by someone else" do
    refute Ability.new(@user_2).can?(:update, @discussion)
  end

  test "authenticated user can update their own Comment" do
    assert Ability.new(@user).can?(:update, @comment)
  end

  test "authenticated user cannot update a Comment made by someone else" do
    refute Ability.new(@user_2).can?(:update, @comment)
  end

  test "authenticated user can read all Comments" do
    assert Ability.new(@user).can?(:read, @comment)
  end

  test "authenticated user can create a Comment" do
    assert Ability.new(@user).can?(:create, @comment)
  end

  test "authenticated user cannot create a Comment on a locked discussion" do
    @discussion.locked = true

    refute Ability.new(@user).can?(:create, @comment)
  end

  test "authenticated user can delete a Comment" do
    assert Ability.new(@user).can?(:delete, @comment)
  end

  test "authenticated user cannot delete a Comment made by someone else" do
    refute Ability.new(@user_2).can?(:delete, @comment)
  end
end