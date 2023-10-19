class Task < ApplicationRecord
    has_many :user_tasks
    has_many :users, through: :user_tasks
    has_many :task_interests
    has_many :interests, through: :task_interests
end
