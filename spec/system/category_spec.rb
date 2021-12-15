require "rails_helper"
require_relative "../modules/helpers"

RSpec.describe "Category", type: :system do
  include SessionHelpers
  include CategoryHelpers

  it "can be created" do
    create_category(DEFAULT_CATEGORY_NAME, CATEGORY_DESCRIPTION)
  end

  it "can be edited after creation" do
    create_category(DEFAULT_CATEGORY_NAME, CATEGORY_DESCRIPTION)
    category_id = Category.find_by(name: DEFAULT_CATEGORY_NAME, description: CATEGORY_DESCRIPTION).id
    edit_category("Test Category 2", "Test category description 2", category_id)
  end

  it "can be deleted after creation" do
    create_category(DEFAULT_CATEGORY_NAME, CATEGORY_DESCRIPTION)

    delete_category(DEFAULT_CATEGORY_NAME, CATEGORY_DESCRIPTION)
  end
end
