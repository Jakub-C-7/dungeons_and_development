class Pathway < ApplicationRecord
    has_many :interest_pathways
    has_many :interests, through: :interest_pathways
    has_many :pathway_sections
    has_many :sections, through: :pathway_sections
    has_many :user_pathways
    has_many :users, through: :user_pathways

end
