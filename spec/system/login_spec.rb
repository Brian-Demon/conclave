require "rails_helper"
require_relative "../modules/helpers"

RSpec.describe "Session", type: :system do
  include SessionHelpers

  context "can be created via" do
    it "login" do
      login_as_user
    end
  end

  context "can be destroyed via" do
    it "logout" do
      login_as_user
      logout
    end
  end
end
