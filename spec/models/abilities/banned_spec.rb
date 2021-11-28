require "rails_helper"

RSpec.describe "A banned user", type: :model do
  before do
    @category = Category.new
    @user = User.new(auth_role: "banned")
    @user2 = User.new
    @discussion = @category.discussions.build(user: @user)
    @comment = @discussion.comments.build(user: @user, body: "This is a test")
  end

  context "does not have User authorization:" do
    it "update auth_role" do
      expect(Ability.new(@user).can?(:update_roles, @user2)).to eq(false)
    end

    it "ban" do
      expect(Ability.new(@user).can?(:ban, @user2)).to eq(false)
    end

    it "unban" do
      expect(Ability.new(@user).can?(:unban, @user2)).to eq(false)
    end
  end

  context "does not have Category authorization:" do
    it "create" do
      expect(Ability.new(@user).can?(:create, @category)).to eq(false)
    end

    it "read" do
      expect(Ability.new(@user).can?(:read, @category)).to eq(false)
    end

    it "update" do
      expect(Ability.new(@user).can?(:update, @category)).to eq(false)
    end

    it "destroy" do
      expect(Ability.new(@user).can?(:destroy, @category)).to eq(false)
    end
  end

  context "does not have Discussion authorization:" do
    it "create" do
      expect(Ability.new(@user).can?(:create, @discussion)).to eq(false)
    end

    it "read" do
      expect(Ability.new(@user).can?(:read, @discussion)).to eq(false)
    end

    it "update" do
      expect(Ability.new(@user).can?(:update, @discussion)).to eq(false)
    end

    it "destroy" do
      expect(Ability.new(@user).can?(:destroy, @discussion)).to eq(false)
    end

    it "lock" do
      expect(Ability.new(@user).can?(:lock, @discussion)).to eq(false)
    end

    it "unlock" do
      expect(Ability.new(@user).can?(:unlock, @discussion)).to eq(false)
    end

    it "pin" do
      expect(Ability.new(@user).can?(:pin, @discussion)).to eq(false)
    end

    it "unpin" do
      expect(Ability.new(@user).can?(:unpin, @discussion)).to eq(false)
    end
  end

  context "does not have Comment authorization:" do
    it "create" do
      expect(Ability.new(@user).can?(:create, @comment)).to eq(false)
    end

    it "read" do
      expect(Ability.new(@user).can?(:read, @comment)).to eq(false)
    end

    it "update" do
      expect(Ability.new(@user).can?(:update, @comment)).to eq(false)
    end

    it "destroy" do
      expect(Ability.new(@user).can?(:destroy, @comment)).to eq(false)
    end
  end
end