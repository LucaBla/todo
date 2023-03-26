class TodoTask < ApplicationRecord
  validates_exclusion_of :deadline, in: [nil]

  belongs_to :todo_user
end
