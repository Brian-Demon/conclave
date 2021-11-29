module SessionHelpers
  def create_user(role)
    User.create(
      login: OmniAuth.config.mock_auth[:google_oauth2][:info][:name],
      provider: OmniAuth.config.mock_auth[:google_oauth2][:provider],
      uid: OmniAuth.config.mock_auth[:google_oauth2][:uid],
      auth_role: role,
    )
  end

  def login_as_user
    create_user("user")
    visit root_path
    click_on "Login"
    expect(page).to have_text("Logged in!")
  end
  
  def login_as_moderator
    create_user("moderator")
    visit root_path
    find_button "Login"
    click_on "Login"
    expect(page).to have_text("Logged in!")
  end

  def login_as_admin
    create_user("admin")
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
  def create_category(category_name, category_description)
    login_as_admin
    find_button "New Category"
    click_on "New Category"
    find_button "Submit"
    fill_in("Name", with: category_name)
    fill_in("Description", with: category_description)
    click_on "Submit"
    should_be_on_categories_page(category_name, category_description)
  end

  def should_be_on_categories_page(category_name, category_description, action = "created")
    expect(page).to have_text("Category was successfully #{action}.")
    expect(page).to have_text("Categories > #{category_name}")
    expect(page).to have_text(category_name)
    expect(page).to have_text(category_description)
    find_button "Edit"
    find_button "Create Discussion"
    expect(page).to have_text("DISCUSSION REPLIES LAST POST")
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
    should_be_on_categories_page(updated_name, updated_description, "updated")
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