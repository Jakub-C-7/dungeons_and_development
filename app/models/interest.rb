class Interest < ApplicationRecord
    has_many :user_interests
    has_many :users, through: :user_interests 
    has_many :section_interests
    has_many :interests, through: :section_interests
    has_many :pathway_interests
    has_many :interests, through: :pathway_interests
end
