class UserInterest < ApplicationRecord
  validates :user_id, uniqueness: true, if: -> {isPrimaryRole}

  belongs_to :user
  belongs_to :interest
end
