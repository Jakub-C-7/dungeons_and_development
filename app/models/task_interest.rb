class TaskInterest < ApplicationRecord
  belongs_to :task
  belongs_to :interest
end
