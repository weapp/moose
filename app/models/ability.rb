class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif !user.new_record?
      can :read, Post, :user_id => user.id
      #can :create, Post, :user_id => user.id
      can :read, Tag, :posts => {:user_id => user.id}
    end
  end
end
