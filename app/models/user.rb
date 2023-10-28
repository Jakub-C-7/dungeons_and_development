class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_interests
  has_many :interests, through: :user_interests 
  belongs_to :character_selection, optional: true
  has_many :user_tasks
  has_many :tasks, through: :user_tasks 
  has_many :user_pathways
  has_many :pathways, through: :user_pathways 
  has_many :user_sections
  has_many :sections, through: :user_sections 
  has_many :user_equipments
  has_many :equipments, through: :user_equipments 
end
