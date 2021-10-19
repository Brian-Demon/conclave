class InstanciateInitialRoleToExistingUsers < ActiveRecord::Migration[6.1]
  def change
    User.where(auth_role: nil).update_all(auth_role: User.default_auth_role)
  end
end
