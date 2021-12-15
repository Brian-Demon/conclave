require "rspec/expectations"

module SharedMatchers
  extend RSpec::Matchers::DSL

  matcher :have_link_tree do |category_name, discussion_title|
    link_tree = "Categories > #{category_name}"
    link_tree += " > #{discussion_title}" if discussion_title != ""
    match do |actual|
      expect(actual).to have_text(link_tree)
    end
    failure_message do |actual|
      "found #{actual} while expecting that the link tree '#{link_tree}' would be present on the page."
    end
  end
end