require "test_helper"

class Ability::AdminTest < ActiveSupport::TestCase
  def setup
    @category = Category.new
    @user = User.new(auth_role: "admin")
    @user_2 = User.new
    @discussion = @category.discussions.build(user: @user)
    @discussion2 = @category.discussions.build(user: @user_2)
    @comment = @discussion.comments.build(user: @user, body: "This is a test")
    @comment2 = @discussion2.comments.build(user: @user_2, body: "This is a test")
  end

  test "can read all Category" do
    assert Ability.new(@user).can?(:read, @category)
  end

  test "can update a Category" do
    assert Ability.new(@user).can?(:update, @category)
  end

  test "can delete a Category" do
    assert Ability.new(@user).can?(:delete, @category)
  end

  test "can read all Discussions" do
    assert Ability.new(@user).can?(:read, @discussion)
  end

  test "can create a Discussion made by someone else" do
    assert Ability.new(@user).can?(:create, @discussion2)
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

  test "can update a Discussion made by someone else" do
    assert Ability.new(@user).can?(:update, @discussion2)
  end

  test "can update their own Comment" do
    assert Ability.new(@user).can?(:update, @comment)
  end

  test "can update a Comment made by someone else" do
    assert Ability.new(@user).can?(:update, @comment2)
  end

  test "can read all Comments" do
    assert Ability.new(@user).can?(:read, @comment)
  end

  test "can create a Comment" do
    assert Ability.new(@user).can?(:create, @comment)
  end

  test "can create a Comment on a locked discussion" do
    @discussion.locked = true

    assert Ability.new(@user).can?(:create, @comment)
  end

  test "can delete a Comment" do
    assert Ability.new(@user).can?(:delete, @comment)
  end

  test "can delete a Comment made by someone else" do
    assert Ability.new(@user).can?(:delete, @comment2)
  end
end