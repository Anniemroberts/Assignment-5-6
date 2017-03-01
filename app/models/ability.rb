class Ability
  include CanCan::Ability

  def initialize(user)

      # this will instantiate the 'user' variable to a new 'User' object if it's nil or undefined
      user ||= User.new

       # this gives super powers to the admin. The admin here can do anything
      if user.is_admin?
        can :manage, :all
      end

      #this defines an ability that declares that the user can 'manage' (edit/create/destroy) on an
      # instance of the Question class if 'q.user == user' meaning if the owner of the question is
      # the currently signed in user.
      can :manage, Post do |p|
        # you should put a boolean expression here, that will return true for who can do the operation.
        # the operation is 'manage' in this case.
        p.user == user
      end
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
  end
end
