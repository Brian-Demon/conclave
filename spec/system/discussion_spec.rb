require "rails_helper"
require_relative "../modules/helpers"

RSpec.describe "Discussion", type: :system do
  include SessionHelpers
  include CategoryHelpers
  include DiscussionHelpers

  it "can be created" do
    create_discussion("Test Discussion Title", "Test discussion body")
  end

  it "can be edited" do
    edit_discussion("Test Discussion Title", "Test discussion body")
  end

  it "can be deleted" do
    delete_category("Test Discussion Title", "Test discussion body")
  end
end