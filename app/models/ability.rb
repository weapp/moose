class Ability
  include CanCan::Ability

  def initialize(user)

    alias_action  :index, :show, :read, :dashboard, :tag, :to => :read_post

    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif !user.new_record?

      # permisos de lectura
      if ['read-only', 'read-one-write-one'].include?(user.auth)
        can :read, User, :id => user.id
        can :read_post, Post, :user_id => user.id
        can :read, Tag, :posts => {:user_id => user.id}
      elsif user.auth == 'read-all-write-one'
        can :read, User
        can :read_post, Post
        can :read, Tag
      end

      # permisos de escritura
      if ['read-all-write-one', 'read-one-write-one'].include?(user.auth)
        can [:create, :update], Post, :user_id => user.id
      end

    end
  end
end
