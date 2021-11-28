require "rails_helper"

RSpec.describe "A guest", type: :model do
  before do
    @category = Category.new
    @user = User.new
    @discussion = @category.discussions.build(user: @user)
    @comment = @discussion.comments.build(user: @user, body: "This is a test")
  end

  context "does not have User authorization:" do
    it "update role" do
      expect(Ability.new(nil).can?(:update_roles, @user)).to eq(false)
    end

    it "ban" do
      expect(Ability.new(nil).can?(:ban, @user)).to eq(false)
    end

    it "unban" do
      expect(Ability.new(nil).can?(:unban, @user)).to eq(false)
    end
  end

  context "has Category authorization:" do
    it "read" do
      expect(Ability.new(nil).can?(:read, @category)).to eq(true)
    end
  end

  context "does not have Category authorization:" do
    it "create" do
      expect(Ability.new(nil).can?(:create, @category)).to eq(false)
    end
  end

  context "has Discussion authorization:" do
    it "read" do
      expect(Ability.new(nil).can?(:read, @discussion)).to eq(true)
    end
  end

  context "does not have Discussion authorization:" do
    it "create" do
      expect(Ability.new(nil).can?(:create, @discussion)).to eq(false)
    end

    it "update" do
      expect(Ability.new(nil).can?(:update, @discussion)).to eq(false)
    end

    it "delete" do
      expect(Ability.new(nil).can?(:delete, @discussion)).to eq(false)
    end

    it "lock" do
      expect(Ability.new(nil).can?(:lock, @discussion)).to eq(false)
    end

    it "unlock" do
      expect(Ability.new(nil).can?(:unlock, @discussion)).to eq(false)
    end

    it "pin" do
      expect(Ability.new(nil).can?(:pin, @discussion)).to eq(false)
    end

    it "unpin" do
      expect(Ability.new(nil).can?(:unpin, @discussion)).to eq(false)
    end
  end

  context "has Comment authorization:" do
    it "read" do
      expect(Ability.new(nil).can?(:read, @comment)).to eq(true)
    end
  end

  context "does not have Comment authorization:" do
    it "create" do
      expect(Ability.new(nil).can?(:create, @comment)).to eq(false)
    end

    it "update" do
      expect(Ability.new(nil).can?(:update, @comment)).to eq(false)
    end

    it "delete" do
      expect(Ability.new(nil).can?(:delete, @comment)).to eq(false)
    end
  end
end