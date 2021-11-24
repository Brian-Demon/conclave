require "rails_helper"

RSpec.describe "A user" do
  context "role" do
    it "will be assigned as default role on creation" do
      user = User.new
      user.save
      expect(user.auth_role).to eq(User.default_auth_role)
    end

    it "cannot be invalid" do
      user = User.new(auth_role: "foo")
      expect(user.valid?).to be(false)
    end

    it "can be assigned ahead of time" do
      role = "banned"
      user = User.new(auth_role: role)
      user.save
      expect(user.auth_role).to eq(role)
    end
  end

  context "banned method" do
    it "should return true when user is banned" do
      user = User.new(auth_role: "banned")
      expect(user.banned?).to be(true)
    end
    it "should return false when user is not banned" do
      user = User.new
      expect(user.banned?).to be(false)
    end
  end
end