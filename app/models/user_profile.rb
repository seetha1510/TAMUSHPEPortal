class UserProfile < ApplicationRecord   
        validates_presence_of :user_email
        validates :user_facebook_profile_url, :format => { :with=> /.*facebook.com.*/,message: "Use a Valid Facebook URL" },allow_nil: true,allow_blank: true
        validates :user_instagram_profile_url, :format => { :with=> /.*instagram.com.*/,message: "Use a Valid Instagram URL" },allow_nil: true ,allow_blank: true
        validates :user_linkedin_profile_url, :format => { :with=> /.*linkedin.com.*/,message: "Use a Valid Linkedin URL" },allow_nil: true ,allow_blank: true
        validates :user_graduating_year, :format=>{:with => /[0-9]{4}/,message: "Enter 4 Digit Year"},allow_nil: true ,allow_blank: true
        validates :user_phone_number, :format => { :with => /\A(\+1)?[0-9]{10}\z/,message: "Use a Valid Phone Number"}, allow_nil: true,allow_blank: true
        validates :user_first_name, presence: {message: "Enter Your First Name"} , allow_nil: false, allow_blank: false
        validates :user_last_name, presence: {message: "Enter Your Last Name"}, allow_nil: false, allow_blank: false
        self.primary_key = "user_id" 
        belongs_to :user
        has_many :employees
        has_many :employers, through: :employees

        before_save {
                user_first_name.downcase!
                user_last_name.downcase!
         }

end