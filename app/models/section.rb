class Section < ApplicationRecord
    has_many :section_tasks
    has_many :tasks, through: :section_tasks
    has_many :section_interests
    has_many :interests, through: :section_interests
    has_many :pathway_sections
    has_many :pathways, through: :pathway_sections
    has_many :user_sections
    has_many :user, through: :user_sections
end
