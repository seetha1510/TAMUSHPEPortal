class School < ApplicationRecord
  has_many :students
  has_many :user_profiles, through: :student
  validates :school_name, presence: true, uniqueness: true
end
