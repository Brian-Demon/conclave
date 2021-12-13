require 'rspec/expectations'
require_relative "../matchers/category_matchers"
require_relative "../matchers/discussion_matchers"
require_relative "../matchers/shared_matchers"

DEFAULT_CATEGORY_NAME = "Test Category Name"
CATEGORY_DESCRIPTION = "Test category description"
DISCUSSION_TITLE = "Test Discussion Title"
DISCUSSION_BODY = "Test discussion body"

module SessionHelpers
  def create_user(role)
    User.create(
      login: OmniAuth.config.mock_auth[:google_oauth2][:info][:name],
      provider: OmniAuth.config.mock_auth[:google_oauth2][:provider],
      uid: OmniAuth.config.mock_auth[:google_oauth2][:uid],
      auth_role: role,
    )
  end

  def login_as(role)
    create_user(role)
    visit root_path
    click_on "Login"
    expect(page).to have_text("Logged in!")
  end

  def logout
    visit root_path
    click_on "Logout"
    expect(page).to have_text("Logged out!")
  end
end

module CategoryHelpers
  include SharedMatchers
  include CategoryMatchers

  def create_category(category_name = DEFAULT_CATEGORY_NAME, category_description)
    login_as("admin")
    find_button "New Category"
    click_on "New Category"
    find_button "Submit"
    fill_in("Name", with: category_name)
    fill_in("Description", with: category_description)
    click_on "Submit"
    expect(page).to have_link_tree(category_name, "")
    expect(page).to have_correct_category_name_on_page(category_name)
    expect(page).to have_correct_category_description_on_page(category_description)
    expect(page).to have_correct_message_for_action("created")
    expect(page).to have_expected_buttons
    expect(page).to have_the_expected_category_header("DISCUSSION REPLIES LAST POST")
  end

  def edit_category(updated_name = "New Title", updated_description = "New Description", category_id)
    within "#category_#{category_id}" do
      click_on "Edit"
    end
    expect(page).to have_text("Editing Category")
    find_button "Show"
    find_button "Back"
    fill_in("Name", with: updated_name)
    fill_in("Description", with: updated_description)
    click_on "Submit"
    expect(page).to have_link_tree(updated_name, "")
    expect(page).to have_correct_category_name_on_page(updated_name)
    expect(page).to have_correct_category_description_on_page(updated_description)
    expect(page).to have_correct_message_for_action("updated")
    expect(page).to have_expected_buttons
    expect(page).to have_the_expected_category_header("DISCUSSION REPLIES LAST POST")
  end

  def delete_category(category_name, category_description)
    category_id = Category.find_by(name: category_name, description: category_description).id
    click_link("Categories")
    expect(page).to have_text("Categories")
    expect(page).to have_text(category_name)
    expect(page).to have_text(category_description)
    within "#category_#{category_id}" do
      click_on "Delete"
    end
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_text("Category was successfully destroyed.")
    expect(page).not_to have_selector("#category_#{category_id}")
  end
end

module DiscussionHelpers
  include SharedMatchers
  include DiscussionMatchers

  def create_discussion(discussion_title, discussion_body, category_name = DEFAULT_CATEGORY_NAME)
    create_category(category_name, CATEGORY_DESCRIPTION)

    find_button "Create Discussion"
    click_on "Create Discussion"
    find_button "Submit"
    fill_in("Title", with: discussion_title)
    fill_in("Body", with: discussion_body)
    click_on "Submit"
    expect(page).to have_link_tree(category_name, DISCUSSION_TITLE)
    expect(page).to have_correct_discussion_title_on_page(discussion_title)
    expect(page).to have_correct_discussion_message_for_action("created")
    expect(page).to have_expected_discussion_buttons
    discussion = Discussion.find_by(title: DISCUSSION_TITLE, body: DISCUSSION_BODY)
    within "#comment-section" do
      expect(page).to have_write_comment_section
    end
    within "#user-info" do
      expect(page).to have_correct_user_info(discussion)
    end

    # Check to make sure all the info for the newly created Discussion are correct
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

    # Return back to the discussion#show for the newly created Discussion so the rest of the specs can work correctly
    within "#discussion-#{discussion.id}-link" do
      click_link DISCUSSION_TITLE
    end
  end

  def edit_discussion(updated_title = "New Title", updated_body = "New Body", category_name = DEFAULT_CATEGORY_NAME, discussion_id)
    create_discussion(DISCUSSION_TITLE, DISCUSSION_BODY)
    discussion = Discussion.find_by(title: DISCUSSION_TITLE, body: DISCUSSION_BODY)

    within "#discussion-title-buttons" do
      click_on "Edit"
    end
    fill_in("Title", with: updated_title)
    fill_in("Body", with: updated_body)
    click_on "Submit"
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

  def delete_category(discussion_title, discussion_body)
    create_discussion(DISCUSSION_TITLE, DISCUSSION_BODY)
    discussion_id = Discussion.find_by(title: discussion_title, body: discussion_body).id
    within "#discussion-title-buttons" do
      click_on "Delete"
    end
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_text("Discussion was successfully deleted.")
    expect(page).to_not have_selector("#discussion_#{discussion_id}")
  end
end