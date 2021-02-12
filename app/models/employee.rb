class Employee < ApplicationRecord
    self.primary_key = "employee_id"
    belongs_to :user_profile, foreign_key: "user_id"
    belongs_to :employer, foreign_key: "employer_id"
    validates :user_id, presence: true, uniqueness: {scope: [:employer_id, :employee_position]}
    validates :employer_id, presence: true
    validates :employee_position, presence: true
end