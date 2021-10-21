class RolesController < ApplicationController
  before_action :ensure_authorization, only: :index

  def index
    # @users = User.where.not(auth_role: "admin")
    @users = User.all
  end

  def update
    @role = params[:user][:auth_role]
    @user = User.find(params[:id])

    if @role == "banned"
      unless can? :ban, @user
        redirect_back(fallback_location: root_path)
        return
      end
    elsif @user.auth_role == "banned" && @role == "user"
      unless can? :unban, @user
        redirect_back(fallback_location: root_path)
        return
      end
    else
      unless can? :update_roles, @user
        redirect_back(fallback_location: root_path)
        return
      end
    end

    if @user.update(auth_role: @role)
      flash[:notice] = "User role updated successfully"
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = "Invalid Role assignment: #{@user.errors.full_messages}"
      redirect_back(fallback_location: root_path)
    end
  end

  def ensure_authorization
    unless current_user && can?(:update_roles, User)
      redirect_back(fallback_location: root_path)
    end
  end
end