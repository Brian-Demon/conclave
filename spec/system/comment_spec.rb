require "rails_helper"
require_relative "../modules/helpers"
require_relative "../matchers/shared_matchers"
require_relative "../matchers/comment_matchers"

RSpec.describe "Comment,", type: :system do
  include SharedMatchers
  include SessionHelpers
  include CommentHelpers

  after do
    User.destroy_all
    Category.destroy_all
    Discussion.destroy_all
    Comment.destroy_all
  end

  context "when logged in as admin" do
    before(:each) do
      login_as("admin")
    end

    let(:category_name) { "Test Category Name" }
    let(:category_description) { "Test category description" }
    let(:discussion_title) { "Test Discussion Title" }
    let(:discussion_body) { "Test discussion body" }
    let(:comment_body) { "Test Comment Body" }
    let(:user) { User.last }
    let(:category) { Category.create(name: category_name, position: 1, description: category_description) }
    let(:discussion) { Discussion.create_or_find_by(category: category, user: user, title: discussion_title, body: discussion_body) }
    let(:comment) { Comment.create_or_find_by(user: user, discussion: discussion, body: comment_body) }

    it "can be created" do
      create_comment(comment_body, category, discussion)
      comment = Comment.find_by(body: comment_body)

      expect(page).to have_correct_comment_info(comment)
    end

    it "can be edited" do
      updated_body = "New Body"
      # comment = Comment.create_or_find_by(user: user, discussion: discussion, body: comment_body)

      visit category_discussion_path(category, discussion)

      edit_comment(comment, updated_body)

      expect(page).to have_text("Comment was successfully updated.")
      within "#comment-#{comment.id}-body" do
        expect(page).to have_text(updated_body)
      end
    end

    it "can be deleted" do
      # comment = Comment.create_or_find_by(user: user, discussion: discussion, body: comment_body)
      visit category_discussion_path(category, discussion)
      
      delete_comment(comment)

      expect(page).to have_text("Comment deleted")
      expect(page).to_not have_selector("#comment-#{comment.id}")
    end
  end
end
