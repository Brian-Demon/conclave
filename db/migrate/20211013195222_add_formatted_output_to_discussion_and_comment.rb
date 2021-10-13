class AddFormattedOutputToDiscussionAndComment < ActiveRecord::Migration[6.1]
  def change
    add_column :discussions, :formatted_body, :text
    add_column :comments, :formatted_body, :text

    Discussion.all.each do |discussion|
      discussion.assign_formatted_body
      discussion.save
    end

    Comment.all.each do |comment|
      comment.assign_formatted_body
      comment.save
    end
  end
end
