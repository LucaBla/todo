class TodoTask < ApplicationRecord
  validates_exclusion_of :deadline, in: [nil]
end
