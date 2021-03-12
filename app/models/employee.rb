# frozen_string_literal: true

class Employee < ApplicationRecord
  belongs_to :user_profile, inverse_of: :employees
  belongs_to :employer
  validates :user_profile_id, presence: true, uniqueness: { scope: %i[employer_id employee_position] },
                              allow_blank: false
  validates :employer_id, presence: true, allow_blank: false
  validates :employee_position, presence: true, allow_blank: false
end
