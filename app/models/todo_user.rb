class TodoUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :jwt_authenticatable,
         :recoverable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

  #has_many :todo_tasks
  #has_and_belongs_to_many :todo_tasks
  has_and_belongs_to_many :participated_tasks, class_name: 'TodoTask'
  has_many :created_todo_tasks, foreign_key: 'creator_id', class_name: 'TodoTask'
  has_many :friendships
  has_many :friends, through: :friendships, source: :friend

  def friends
    friend_ids = Friendship.where(todo_user_id: id, accepted: true).pluck(:friend_id)
    TodoUser.where(id: friend_ids)
  end

  def add_friend(user)
    friendships.create(friend: user)
  end

  def all_todo_tasks
    created_tasks = self.created_todo_tasks
    
    participated_tasks = self.participated_tasks

    todo_tasks = created_tasks.append(participated_tasks)
  end
end
