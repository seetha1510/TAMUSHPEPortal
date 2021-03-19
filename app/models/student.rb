class Student < ApplicationRecord
  belongs_to :user_profile, inverse_of: :students
  belongs_to :school
  validates :user_profile_id, presence: true, uniqueness: { scope: %i[school_id student_degree student_field_of_study] },
                              allow_blank: false
  validates :school_id, presence: { message: 'Enter a School Name' }, allow_blank: false
  validates :student_degree, presence: true, allow_blank: false
  validates :student_field_of_study, presence: { message: 'Enter a Field of Study' }, allow_blank: false
  validates :degree_start_date, presence: true, allow_blank: false
  validates :degree_end_date, presence: false, allow_blank: true
end
