class ChangeCommentBodyToText < ActiveRecord::Migration[6.1]
  def change
    change_column :comments, :body, :text
  end
end
