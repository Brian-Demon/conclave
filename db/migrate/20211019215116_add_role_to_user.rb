class AddRoleToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :auth_role, :string
  end
end
