class Employee < ApplicationRecord
    self.primary_keys = "employee_id"
    belongs_to :user_profile, foreign_key: "user_id"
    belongs_to :employer, foreign_key: "employer_id"
end