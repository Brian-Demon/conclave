require "rails_helper"
require "cancan/matchers"

describe "User" do
  describe "ability," do
    subject(:ability) { Ability.new(user)}
    let!(:other_user) { User.create }
    let!(:category) { Category.create(name: "Test Category Name") }
    let!(:discussion_made_by_user) { Discussion.create(category: category, user: user, body: "User Discussion Body") }
    let!(:discussion_made_by_other_user) { Discussion.create(category: category, user: other_user, body: "Other User Discussion Body") }
    let!(:comment_made_by_user) { Comment.create(discussion: discussion_made_by_user, user: user, body: "User Comment Body") }
    let!(:comment_made_by_other_user) { Comment.create(discussion: discussion_made_by_other_user, user: other_user, body: "Other User Comment Body") }

    context "when they are an admin," do
      let(:user) { User.new(auth_role: "admin") }

      %i[ ban unban update_roles ].each do |ability|
        it { is_expected.to be_able_to(ability, other_user) }
      end

      %i[ create read delete ].each do |ability|
        it { is_expected.to be_able_to(ability, category) }
        it { is_expected.to be_able_to(ability, discussion_made_by_user) }
        it { is_expected.to be_able_to(ability, comment_made_by_user) }
        it { is_expected.to be_able_to(ability, comment_made_by_other_user) }
        it { is_expected.to be_able_to(ability, discussion_made_by_user) }
      end

      %i[ lock unlock pin unpin ].each do |ability|
        it { is_expected.to be_able_to(ability, discussion_made_by_other_user) }
      end
    end

    context "when they are a moderator," do
      let(:user) { User.new(auth_role: "moderator") }

      # User abilities
      %i[ ban unban ].each do |ability|
        it { is_expected.to be_able_to(ability, other_user) }
      end
      it { is_expected.to_not be_able_to(:update_roles, other_user) }

      # Category abilities
      %i[ create update delete ].each do |ability|
        it { is_expected.to_not be_able_to(ability, category) }
      end
      it { is_expected.to be_able_to(:read, category) }

      # Discussion & Comment abilities
      %i[ create update ].each do |ability|
        it { is_expected.to be_able_to(ability, comment_made_by_user) }
        it { is_expected.to be_able_to(ability, discussion_made_by_user) }
        it { is_expected.to_not be_able_to(ability, discussion_made_by_other_user) }
        it { is_expected.to_not be_able_to(ability, comment_made_by_other_user) }
      end

      %i[ read delete ].each do |ability|
        it { is_expected.to be_able_to(ability, discussion_made_by_user) }
        it { is_expected.to be_able_to(ability, discussion_made_by_other_user) }
        it { is_expected.to be_able_to(ability, comment_made_by_user) }
        it { is_expected.to be_able_to(ability, comment_made_by_other_user) }
      end

      %i[ lock unlock pin unpin ].each do |ability|
        it { is_expected.to be_able_to(ability, discussion_made_by_other_user) }
      end
    end

    context "when they are a guest," do
      let(:user) { nil }

      # User abilities
      %i[ ban unban update_roles ].each do |ability|
        it { is_expected.to_not be_able_to(ability, other_user) }
      end

      # Category abilities
      %i[ create update delete ].each do |ability|
        it { is_expected.to_not be_able_to(ability, category) }
      end
      it { is_expected.to be_able_to(:read, category) }

      # Discussion & Comment abilities
      %i[ create update delete ].each do |ability|
        it { is_expected.to_not be_able_to(ability, comment_made_by_user) }
        it { is_expected.to_not be_able_to(ability, discussion_made_by_user) }
        it { is_expected.to_not be_able_to(ability, discussion_made_by_other_user) }
        it { is_expected.to_not be_able_to(ability, comment_made_by_other_user) }
      end

      %i[ read ].each do |ability|
        it { is_expected.to be_able_to(ability, discussion_made_by_user) }
        it { is_expected.to be_able_to(ability, discussion_made_by_other_user) }
        it { is_expected.to be_able_to(ability, comment_made_by_user) }
        it { is_expected.to be_able_to(ability, comment_made_by_other_user) }
      end

      %i[ lock unlock pin unpin ].each do |ability|
        it { is_expected.to_not be_able_to(ability, discussion_made_by_other_user) }
      end
    end

    context "when they are a authenticated user," do
      let(:user) { User.new(auth_role: "user") }

      # User abilities
      %i[ ban unban update_roles ].each do |ability|
        it { is_expected.to_not be_able_to(ability, other_user) }
      end

      # Category abilities
      %i[ create update delete ].each do |ability|
        it { is_expected.to_not be_able_to(ability, category) }
      end
      it { is_expected.to be_able_to(:read, category) }

      # Discussion & Comment abilities
      %i[ create update delete ].each do |ability|
        it { is_expected.to be_able_to(ability, comment_made_by_user) }
        it { is_expected.to be_able_to(ability, discussion_made_by_user) }
        it { is_expected.to_not be_able_to(ability, discussion_made_by_other_user) }
        it { is_expected.to_not be_able_to(ability, comment_made_by_other_user) }
      end

      %i[ read ].each do |ability|
        it { is_expected.to be_able_to(ability, discussion_made_by_user) }
        it { is_expected.to be_able_to(ability, discussion_made_by_other_user) }
        it { is_expected.to be_able_to(ability, comment_made_by_user) }
        it { is_expected.to be_able_to(ability, comment_made_by_other_user) }
      end

      %i[ lock unlock pin unpin ].each do |ability|
        it { is_expected.to_not be_able_to(ability, discussion_made_by_other_user) }
      end
    end

    context "when they are a banned user," do
      let(:user) { User.new(auth_role: "banned") }

      # User abilities
      %i[ ban unban update_roles ].each do |ability|
        it { is_expected.to_not be_able_to(ability, other_user) }
      end

      # Category abilities
      %i[ read create update delete ].each do |ability|
        it { is_expected.to_not be_able_to(ability, category) }
      end

      # Discussion & Comment abilities
      %i[ read create update delete ].each do |ability|
        it { is_expected.to_not be_able_to(ability, comment_made_by_user) }
        it { is_expected.to_not be_able_to(ability, discussion_made_by_user) }
        it { is_expected.to_not be_able_to(ability, discussion_made_by_other_user) }
        it { is_expected.to_not be_able_to(ability, comment_made_by_other_user) }
      end

      %i[ lock unlock pin unpin ].each do |ability|
        it { is_expected.to_not be_able_to(ability, discussion_made_by_other_user) }
      end
    end
  end
end