class UserProfile < ApplicationRecord
        validates_presence_of :user_email
        validates :user_facebook_profile_url, :format => { :with=> /.*facebook.com.*/,message: "use a valid facebook url" },allow_nil: true
        validates :user_facebook_profile_url, :format => { :with=> /.*instagram.com.*/,message: "use a valid instagram url" },allow_nil: true 
        validates :user_phone_number, :format => { :with => /\A(\+1)?[0-9]{10}\z/,message: "use a valid phone_number"}, allow_nil: true
        self.primary_key = "user_id" 
        belongs_to :user
        has_many :employees
        has_many :employers, through: :employees
end