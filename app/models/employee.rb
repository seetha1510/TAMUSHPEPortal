# frozen_string_literal: true

class Employee < ApplicationRecord
  belongs_to :user_profile, inverse_of: :employees
  belongs_to :employer
  validates :user_profile_id, presence: true, uniqueness: { scope: %i[employer_id employee_position] },
                              allow_blank: false
  validates :employer_id, presence: { message: 'Enter an Employer' }, allow_blank: false
  validates :employee_position, presence: { message: 'Enter a Position' }, allow_blank: false
  validates :position_start_date, presence: { message: 'Enter a Start Date' }, allow_blank: false
  validates :position_end_date, presence: false, allow_blank: true
  validates :position_location_state, presence: { message: 'Enter a State' }, allow_blank: false
  validates :position_location_city, presence: { message: 'Enter a City' }, allow_blank: false
end
