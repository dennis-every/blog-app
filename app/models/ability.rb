class Ability
  include CanCan::Ability

  def initialize(user)
    # starting rules for all users
    can :read, Post, public: true
    can :read, Comment, public: true

    # additional permissions for logged in users
    return unless user.present?

    can :destroy, Post do |post|
      post.author == user
    end

    can :destroy, Comment do |comment|
      comment.author == user
    end

    can :read, User, id: user.id

    # additional permissions for admin users
    return unless user.role == 'admin'

    can :destroy, Comment
    can :destroy, Post
    can :read, User, :auth_token
  end
end
