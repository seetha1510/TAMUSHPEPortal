class UserProfile < ApplicationRecord
        validates_presence_of :user_email
        validates :user_phone_number, :format => { :with => /\A(\+1)?[0-9]{10}\z/}, allow_nil: true
        self.primary_key = "user_id" 
        belongs_to :user
        has_many :employees
        has_many :employers, through: :employees
end