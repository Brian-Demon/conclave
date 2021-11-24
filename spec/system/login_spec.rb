require "rails_helper"

RSpec.describe "login", type: :system do
  it "succesful" do
    visit root_path
    click_on "Login"
    expect(page).to have_text("Logged in!")
  end
end
