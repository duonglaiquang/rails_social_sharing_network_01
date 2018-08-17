class Ability
  include CanCan::Ability

  def initialize user
    if !user.present?
      can :read, :all
    elsif user.admin?
      can :manage, :all
    else
      can :manage, Post, user_id: user.id
    end
  end
end
