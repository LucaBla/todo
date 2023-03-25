class TodoUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

  has_many :todo_tasks
  has_many :friendships
  has_many :friends, through: :friendships, source: :friend

  def friends
    friend_ids = Friendship.where(todo_user_id: id, accepted: true).pluck(:friend_id)
    TodoUser.where(id: friend_ids)
  end

  def add_friend(user)
    friendships.create(friend: user)
  end
end
