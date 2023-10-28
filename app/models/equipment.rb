class Equipment < ApplicationRecord
  belongs_to :pathway
  has_many :user_equipments
  has_many :users, through: :user_equipments 

  enum category: {
    helmet: 0,
    weapon: 1,
    chest: 2,
    bottoms: 3,
    decor: 4 
  }
end
