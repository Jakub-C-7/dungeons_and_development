class UserInterest < ApplicationRecord
  validates_uniqueness_of :user_id, conditions: -> { where(isPrimaryRole: true) }

  belongs_to :user
  belongs_to :interest
end
