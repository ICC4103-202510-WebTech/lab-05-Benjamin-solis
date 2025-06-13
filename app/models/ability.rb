# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here
    user ||= User.new # guest user (not logged in)

    if user.persisted? # logged in user
      can :read, Chat, sender_id: user.id
      can :read, Chat, receiver_id: user.id
      can :create, Chat
      can :update, Chat, sender_id: user.id
      can :update, Chat, receiver_id: user.id

      can :read, Message, user_id: user.id
      can :read, Message, chat: { sender_id: user.id }
      can :read, Message, chat: { receiver_id: user.id }
      can :create, Message
      can :update, Message, user_id: user.id
      can :destroy, Message, user_id: user.id

      can :read, User
      can :update, User, id: user.id
      can :show, User
    end
  end
end
