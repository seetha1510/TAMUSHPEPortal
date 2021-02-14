class Employer < ApplicationRecord
        self.primary_key = "employer_id"
        has_many :employees
        has_many :user_profiles, through: :employee
        validates :employer_name, presence: true, uniqueness: true
end