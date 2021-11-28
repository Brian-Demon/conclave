require "rails_helper"

RSpec.describe "A moderator", type: :model do
  before do
    @category = Category.new
    @user = User.new(auth_role: "moderator")
    @user2 = User.new
    @discussion = @category.discussions.build(user: @user)
    @discussion2 = @category.discussions.build(user: @user2)
    @comment = @discussion.comments.build(user: @user, body: "This is a test")
    @comment2 = @discussion2.comments.build(user: @user2, body: "This is a test")
  end

  context "has User authorization:" do
    it "ban" do
      expect(Ability.new(@user).can?(:ban, @user2)).to eq(true)
    end

    it "unban" do
      expect(Ability.new(@user).can?(:unban, @user2)).to eq(true)
    end
  end

  context "has Category authorization:" do
    it "read" do
      expect(Ability.new(@user).can?(:read, @category)).to eq(true)
    end
  end

  context "does not have Category authorization:" do
    it "create" do
      expect(Ability.new(@user).can?(:create, @category)).to eq(false)
    end

    it "update" do
      expect(Ability.new(@user).can?(:update, @category)).to eq(false)
    end

    it "destroy" do
      expect(Ability.new(@user).can?(:destroy, @category)).to eq(false)
    end
  end

  context "has Discussion authorization:" do
    it "create" do
      expect(Ability.new(@user).can?(:create, @discussion)).to eq(true)
    end

    it "read" do
      expect(Ability.new(@user).can?(:read, @discussion)).to eq(true)
    end

    it "read (made by someone else)" do
      expect(Ability.new(@user).can?(:read, @discussion2)).to eq(true)
    end

    it "update" do
      expect(Ability.new(@user).can?(:update, @discussion)).to eq(true)
    end

    it "delete" do
      expect(Ability.new(@user).can?(:delete, @discussion)).to eq(true)
    end

    it "delete (made by someone else)" do
      expect(Ability.new(@user).can?(:delete, @discussion2)).to eq(true)
    end

    it "lock" do
      expect(Ability.new(@user).can?(:lock, @discussion)).to eq(true)
    end

    it "unlock" do
      expect(Ability.new(@user).can?(:unlock, @discussion)).to eq(true)
    end

    it "lock (made by someone else)" do
      expect(Ability.new(@user).can?(:lock, @discussion2)).to eq(true)
    end

    it "unlock (made by someone else)" do
      expect(Ability.new(@user).can?(:unlock, @discussion2)).to eq(true)
    end

    it "pin" do
      expect(Ability.new(@user).can?(:pin, @discussion)).to eq(true)
    end

    it "unpin" do
      expect(Ability.new(@user).can?(:unpin, @discussion)).to eq(true)
    end

    it "pin (made by someone else)" do
      expect(Ability.new(@user).can?(:pin, @discussion2)).to eq(true)
    end

    it "unpin (made by someone else)" do
      expect(Ability.new(@user).can?(:unpin, @discussion2)).to eq(true)
    end
  end

  context "has Comment authorization:" do
    it "create" do
      expect(Ability.new(@user).can?(:create, @comment)).to eq(true)
    end

    it "read" do
      expect(Ability.new(@user).can?(:read, @comment)).to eq(true)
    end

    it "read (made by someone else)" do
      expect(Ability.new(@user).can?(:read, @comment2)).to eq(true)
    end

    it "update" do
      expect(Ability.new(@user).can?(:update, @comment)).to eq(true)
    end

    it "delete" do
      expect(Ability.new(@user).can?(:delete, @comment)).to eq(true)
    end

    it "delete (made by someone else)" do
      expect(Ability.new(@user).can?(:delete, @comment2)).to eq(true)
    end
  end
end