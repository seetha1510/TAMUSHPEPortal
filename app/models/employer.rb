class Employer < ApplicationRecord
        self.primary_key = "employer_id"
        has_many :employees
        has_many :user_profiles, through: :employee 
end