class Ability
  include CanCan::Ability
  
  def initialize(user)
      user ||= User.new # guest user (not logged in)
      if user.admin?
        can :manage, :all
      else
        can :read, :all
        can :mine, Folder
        can :checkin, Folder
        can :checkedin, Folder
        can :update, Folder
        can :move, Folder # This needs to be  limited to his folders
      end
    end

end
