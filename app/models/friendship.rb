class Friendship < ApplicationRecord
  belongs_to :todo_user
  belongs_to :friend, class_name: 'TodoUser'

  validates :todo_user_id, uniqueness: { scope: :friend_id }

  def self.befriend(todo_user, friend)
    if todo_user == friend
      return false
    end
    transaction do
      create(todo_user: todo_user, friend: friend, creator_id: todo_user.id)
      create(todo_user: friend, friend: todo_user, creator_id: todo_user.id)
    end
    return true
  end

  def find_symmetric_friendship
    Friendship.find_by(todo_user: friend, friend: todo_user)
  end
end
