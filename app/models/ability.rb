# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    can :read, Discussion
    can :read, Comment
    can :read, Category

    return unless user.present?

    if user.auth_role == "banned"
      cannot :read, Discussion
      cannot :read, Category
      cannot :read, Comment
      return 
    end

    can :create, Discussion, user: user
    can :delete, Discussion, user: user
    can :update, Discussion, user: user

    can :create, Comment, discussion: { locked: false }
    can :update, Comment, user: user
    can :delete, Comment, user: user

    if user.auth_role == "admin"
      can :create, Category
      can :update, Category
      can :delete, Category
      can :create, Discussion
      can :delete, Discussion
      can :update, Discussion
      can :lock, Discussion
      can :unlock, Discussion
      can :update, Comment
      can :delete, Comment
      can :create, Comment
      can :update_roles, User
      can :ban, User
      can :unban, User
      can :pin, Discussion
      can :unpin, Discussion
    end

    if user.auth_role == "moderator"
      can :lock, Discussion
      can :unlock, Discussion
      can :delete, Discussion
      can :ban, User
      can :unban, User
      can :delete, Comment
      can :pin, Discussion
      can :unpin, Discussion
    end
  end
end
