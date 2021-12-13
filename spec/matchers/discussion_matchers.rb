require "rspec/expectations"

module DiscussionMatchers
  extend RSpec::Matchers::DSL

  matcher :have_correct_discussion_title_on_page do |discussion_title|
    match do |actual|
      expect(actual).to have_text(discussion_title)
    end
    failure_message do |actual|
      "expected that the discussion title '#{discussion_title}' would be present on the page."
    end
  end

  matcher :have_correct_discussion_body_on_page do |discussion_body|
    match do |actual|
      expect(actual).to have_text(discussion_body)
    end
    failure_message do |actual|
      "expected that the discussion body '#{discussion_body}' would be present on the page."
    end
  end

  matcher :have_correct_discussion_message_for_action do |action|
    expected_text = "Discussion was successfully #{action}."
    match do |actual|
      expect(actual).to have_text(expected_text)
    end
    failure_message do |actual|
      "expected that the message '#{expected_text}' would be present on the page for the appropriate action."
    end
  end

  matcher :have_expected_discussion_moderator_buttons do
    match do
      find_button "Ban"
      find_button "Pin"
      find_button "Lock"
    end
    failure_message do
      "expected that the moderator buttons exist on the page."
    end
  end

  matcher :have_expected_discussion_buttons do
    match do
      find_button "Edit"
      find_button "Delete"
    end
    failure_message do
      "expected that the default normal user buttons exist on the page."
    end
  end

  matcher :have_write_comment_section do
    match do |actual|
      expect(actual).to have_text("Write a Comment")
      expect(actual).to have_text("Write")
      expect(actual).to have_text("Preview")
      expect(actual).to have_text("Body")
      find_button "Submit"
    end
  end

  matcher :have_correct_user_info do |discussion|
    match do |actual|
      expect(actual).to have_text(discussion.user.login)
      expect(actual).to have_text("Posts: #{discussion.user.post_count}")
    end
  end
end
