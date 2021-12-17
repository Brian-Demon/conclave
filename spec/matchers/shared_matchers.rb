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

  matcher :have_correct_user_info do |discussion|
    match do |actual|
      expect(actual).to have_text(discussion.user.login)
      expect(actual).to have_text("Posts: #{discussion.user.post_count}")
    end
    failure_message do
      "Discussion Count: #{Discussion.count}, Discussion First: #{Discussion.first.title}, Discussion Last: #{Discussion.last.title}"
    end
  end

  matcher :have_expected_buttons do |buttons|
    buttons.map do |button|
      match do
        find_button button
      end
      failure_message do
        "expected to find the button '#{button}' on the page."
      end
    end
  end
end