class Pathway < ApplicationRecord
    has_many :pathway_interests
    has_many :interests, through: :pathway_interests
    has_many :pathway_sections
    has_many :sections, through: :pathway_sections
    has_many :user_pathways
    has_many :users, through: :user_pathways
    has_one :equipment

end
