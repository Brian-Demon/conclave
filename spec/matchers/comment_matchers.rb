require "rspec/expectations"

module CommentMatchers
  extend RSpec::Matchers::DSL

  matcher :have_correct_comment_info do |comment|
    match do |actual|
      within "#comment-#{comment.id}-posted-info" do
        expect(actual).to have_text(comment.created_at.strftime("%m/%d/%Y %I:%M%p"))
      end
      within "#comment-#{comment.id}-buttons" do
        expect(page).to have_expected_buttons(["Edit", "Delete"])
      end
      within "#comment-#{comment.id}-body" do
        expect(actual).to have_text(comment.body)
      end
    end
  end
end
