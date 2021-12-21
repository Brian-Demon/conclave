require 'rspec/expectations'
require_relative "../matchers/shared_matchers"
require_relative "../matchers/category_matchers"
require_relative "../matchers/discussion_matchers"
require_relative "../matchers/comment_matchers"

DEFAULT_CATEGORY_NAME = "Test Category Name"
CATEGORY_DESCRIPTION = "Test category description"

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

  def create_discussion(discussion_title, discussion_body, category)
    visit category_path(category)

    find_button "Create Discussion"
    click_on "Create Discussion"
    find_button "Submit"
    fill_in("Title", with: discussion_title)
    fill_in("Body", with: discussion_body)
    click_on "Submit"
  end

  def edit_discussion(discussion, updated_title = "New Title", updated_body = "New Body")
    within "#discussion-#{discussion.id}-buttons" do
      click_on "Edit"
    end
    fill_in("Title", with: updated_title)
    fill_in("Body", with: updated_body)
    click_on "Submit"
  end

  def delete_discussion(discussion)
    within "#discussion-#{discussion.id}-buttons" do
      click_on "Delete"
    end
    page.driver.browser.switch_to.alert.accept
  end
end

module CommentHelpers
  include SharedMatchers
  include CommentMatchers

  def create_comment(comment_body, category, discussion)
    visit category_discussion_path(category, discussion)

    within "#comment-section" do
      fill_in("Body", with: comment_body)
      click_on "Submit"
    end

    expect(page).to have_text("Comment posted!")
  end

  def edit_comment(comment, updated_body = "New Body")
    within "#comment-#{comment.id}-buttons" do
      click_on("Edit")
    end
    fill_in("Body", with: updated_body)
    click_on "Submit"
  end

  def delete_comment(comment)
    within "#comment-#{comment.id}-buttons" do
      click_on "Delete"
    end
    page.driver.browser.switch_to.alert.accept
  end
end

module UserRolesHelpers
  def click_on_user_roles_header_button
    within "#header-buttons" do
      click_on "User Roles"
    end
    expect(page).to have_text("User Roles Page")
  end

  def select_auth_role_for(user, new_role = user.auth_role)
    within "#user-#{user.id}" do
      select(new_role, from: "user_auth_role")
    end
  end
end
