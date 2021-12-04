require "rails_helper"
require_relative "../modules/helpers"

RSpec.describe "Category", type: :system do
  include SessionHelpers
  include CategoryHelpers

  it "can be created" do
    create_category("Test Category", "Test category description")
  end

  it "can be edited after creation" do
    category_name = "Test Category"
    category_description = "Test category description"
    create_category(category_name, category_description)
    category_id = Category.find_by(name: category_name, description: category_description).id
    edit_category("Test Category 2", "Test category description 2", category_id)
  end

  it "can be deleted after creation" do
    create_category("Test Category", "Test category description")

    delete_category("Test Category", "Test category description")
  end
end
