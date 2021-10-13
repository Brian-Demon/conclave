class ChangeDiscussionBodyToText < ActiveRecord::Migration[6.1]
  def change
    change_column :discussions, :body, :text 
  end
end
