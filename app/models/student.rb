class Student < ApplicationRecord
  belongs_to :user_profile, inverse_of: :students
  belongs_to :school
  attr_accessor :school_name
end
