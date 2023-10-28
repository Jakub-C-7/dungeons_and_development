class Equipment < ApplicationRecord
  belongs_to :pathway
  has_many :user_equipments
  has_many :users, through: :user_equipments 
end
