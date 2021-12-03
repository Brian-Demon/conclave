require "rspec/expectations"

module CategoryHelpers
  extend RSpec::Matchers::DSL

  matcher :have_correct_category_name_on_page do |category_name|
    match do |actual|
      expect(actual).to have_text(category_name)
    end
    failure_message do |actual|
      "expected that the category '#{category_name}' would be present on the page."
    end
  end

  matcher :have_correct_category_description_on_page do |category_description|
    match do |actual|
      expect(actual).to have_text(category_description)
    end
    failure_message do |actual|
      "expected that the category description '#{category_description}' would be present on the page."
    end
  end

  matcher :have_correct_message_for_action do |action|
    match do |actual|
      expect(actual).to have_text("Category was successfully #{action}.")
    end
    failure_message do |actual|
      "expected that the message 'Category was successfully #{action}.' would be present on the page for the appropriate action."
    end
  end

  matcher :have_expected_buttons do
    match do
      find_button "Edit"
      find_button "Create Discussion"
    end
    failure_message do
      "expected that the buttons `Edit` and `Create Discussion` exist on the page."
    end
  end

  matcher :have_the_expected_category_header do |category_header|
    match do |actual|
      expect(actual).to have_text(category_header)
    end
    failure_message do |actual|
      "expected that the category header '#{category_header}' for the categories table is on the page."
    end
  end
end