class UserPathway < ApplicationRecord
  belongs_to :user
  belongs_to :pathway

  enum progress: {
    notStarted: 0,
    started: 1,
    completed: 2 
  }
end
