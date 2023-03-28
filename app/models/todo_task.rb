class TodoTask < ApplicationRecord
  validates_exclusion_of :deadline, in: [nil]

  #belongs_to :todo_user
  #has_and_belongs_to_many :todo_users
  has_and_belongs_to_many :participants, class_name: 'TodoUser'
  belongs_to :creator, class_name: 'TodoUser'
end
