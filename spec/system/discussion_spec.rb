require "rails_helper"
require_relative "../modules/helpers"
require_relative "../matchers/category_matchers"
require_relative "../matchers/discussion_matchers"
require_relative "../matchers/shared_matchers"

RSpec.describe "Discussion,", type: :system do
  include SharedMatchers
  include SessionHelpers
  include CategoryHelpers
  include DiscussionHelpers

  context "when logged in as admin," do
    before(:each) do
      login_as("admin")
    end

    let(:category_name) { "Test Category Name" }
    let(:discussion_title) { "Test Discussion Title" }
    let(:discussion_body) { "Test discussion body" }

    it "can be created" do
      create_discussion(discussion_title, discussion_body)
      discussion = Discussion.find_by(title: discussion_title, body: discussion_body)

      expect(page).to have_link_tree(category_name, discussion_title)
      expect(page).to have_correct_discussion_title_on_page(discussion_title)
      expect(page).to have_correct_discussion_message_for_action("created")
      expect(page).to have_expected_discussion_buttons
      within "#comment-section" do
        expect(page).to have_write_comment_section
      end
      within "#user-info" do
        expect(page).to have_correct_user_info(discussion)
      end
      within "#link-tree" do
        click_link category_name
      end
      expect(page).to have_the_expected_category_header("DISCUSSION REPLIES LAST POST")
      within "#discussion-#{discussion.id}" do
        find_by_id("discussion-#{discussion.id}-link")
      end
      within "#discussion-#{discussion.id}-info" do
        expect(page).to have_text(discussion.user.login)
        expect(page).to have_text(discussion.created_at.strftime("%m/%d/%Y %I:%M%p"))
      end
      within "#discussion-#{discussion.id}-replies .reply-counter" do
        expect(page).to have_text(discussion.comments.count)
      end
    end

    it "can be edited" do
      updated_title = "New Title"
      updated_body = "New Body"

      create_discussion(discussion_title, discussion_body)
      discussion = Discussion.find_by(title: discussion_title, body: discussion_body)

      edit_discussion(updated_title, updated_body)

      expect(page).to have_link_tree(category_name, updated_title)
      expect(page).to have_correct_discussion_title_on_page(updated_title)
      expect(page).to have_correct_discussion_message_for_action("updated")
      expect(page).to have_expected_discussion_buttons
      within "#user-info" do
        expect(page).to have_correct_user_info(discussion)
      end
      within "#comment-section" do
        expect(page).to have_write_comment_section
      end
    end

    it "can be deleted" do
      create_discussion(discussion_title, discussion_body)
      discussion = Discussion.find_by(title: discussion_title, body: discussion_body)

      delete_discussion

      expect(page).to have_text("Discussion was successfully deleted.")
      expect(page).to_not have_selector("#discussion_#{discussion.id}")
    end
  end
end
