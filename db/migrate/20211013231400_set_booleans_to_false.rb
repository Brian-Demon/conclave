class SetBooleansToFalse < ActiveRecord::Migration[6.1]
  def change
    change_column :discussions, :locked, :boolean, default: false
    change_column :discussions, :pinned, :boolean, default: false
  end
end
