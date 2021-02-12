class UserProfile < ApplicationRecord
        self.primary_key = "user_id" 
        belongs_to :user
        has_many :employees
        has_many :employers, through: :employees
end