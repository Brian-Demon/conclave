class RolesController < ApplicationController
  def index
    # @users = User.where.not(auth_role: "admin")
    @users = User.all
  end

  def update
    if can? :update_roles, User
      @user = User.find(params[:id])
      if @user.update(auth_role: params[:user][:auth_role])
        redirect_to roles_path, notice: "User role updated successfully"
      else
        render :index, notice: "Invalid Role assignment: #{@user.errors.full_messages}", status: 422
      end
    else
      redirect_to root_url, status: 403
    end
  end
end