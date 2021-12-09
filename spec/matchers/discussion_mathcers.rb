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

  matcher :have_expected_discussion_buttons do
    match do
      find_button "Ban"
      find_button "Pin"
      find_button "Lock"
      find_button "Edit"
      find_button "Delete"
    end
    failure_message do
      "expected that the buttons `Edit` and `Create Discussion` exist on the page."
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

  matcher :have_correct_user_info do
    match do |actual|
      expect(actual).to have_text("Test Person")
      expect(actual).to have_text("Posts: 1")
      find_button "Ban"
    end
  end

  matcher :have_correct_discussion_info do |discussion|
    discussion_info = "by\n#{discussion.user.login}\non\n#{discussion.created_at.strftime("%m/%d/%Y %I:%M%p")}"
    match do |actual|
      expect(actual).to have_text(discussion_info)
    end
    failure_message do |actual|
      "expected that the discussion info within discussion table to be '#{discussion_info}' for the categories table is on the page."
    end
  end

  matcher :have_correct_last_post_info do |discussion|
    last_poster = "Last post by #{discussion.user.login}"
    last_post_timestamp = discussion.created_at.strftime("%m/%d/%Y %I:%M%p")
    match do |actual|
      expect(actual).to have_text(last_poster)
      expect(actual).to have_text(last_post_timestamp)
    end
    failure_message do |actual|
      "expected that the discussion info within Last Post to be '#{last_poster}' & '#{last_post_timestamp}' is on the page."
    end
  end

  matcher :have_correct_reply_info do |discussion|
    number_of_replies = discussion.comments.count
    match do |actual|
      expect(actual).to have_text(number_of_replies)
    end
    failure_message do |actual|
      "expected that the number of replies (comments) for the discussion equals '#{number_of_replies}' is on the page."
    end
  end
end