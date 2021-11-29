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
  def should_be_on_categories_page(category_name, category_description)
    expect(page).to have_text("Category was successfully created.")
    expect(page).to have_text("Conclave > #{category_name}")
    expect(page).to have_text(category_name)
    expect(page).to have_text(category_description)
    find_button "Edit"
    find_button "Create Discussion"
    expect(page).to have_text("DISCUSSION REPLIES LAST POST")
  end
end