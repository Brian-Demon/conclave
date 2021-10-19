require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "user will be assigned default role on creation" do
    user = User.new
    user.save

    assert_equal User.default_auth_role, user.auth_role
  end

  test "user role can be assigned ahead of time" do
    user = User.new(auth_role: "banned")
    user.save

    assert_equal "banned", user.auth_role
  end

  test "user role cannot be invalid" do
    user = User.new(auth_role: "foo")

    refute user.valid?
  end
end
