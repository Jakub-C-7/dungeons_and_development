class Section < ApplicationRecord
    has_many :section_tasks
    has_many :tasks, through: :section_tasks
    has_many :section_interests
    has_many :interests, through: :section_interests
end
