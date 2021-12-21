require "rails_helper"
require_relative "../modules/helpers"

RSpec.describe "User Roles,", type: :system do
  include SessionHelpers
  include UserRolesHelpers

  ROLES = %w{admin moderator user banned}
  let(:user) { User.create(login: "user", provider: "google_oauth2", uid: 2, auth_role: "user") }

  context "when logged in as admin," do
    before(:each) do
      User.destroy_all
      login_as("admin")
    end

    it "should visit users/roles path" do
      click_on_user_roles_header_button
    end

    ROLES.each do |role|
      it "should be able to change the role of a user to #{role}" do
        user
        click_on_user_roles_header_button

        if user.auth_role != role
          select_auth_role_for(user, role.capitalize)
          
          expect(page).to have_text("User role updated successfully")
          within "#user-#{user.id} #user_auth_role" do
            expect(page).to have_text(role.capitalize )
            expect(user.auth_role).to eq(role)
          end
        end
      end
    end
  end
end