class Employer < ApplicationRecord

        self.primary_key = "employer_id"
    
    #sets up associative entity "employee" 
    #should use the through: when extra attributes are needed on the relationship 
        has_many :employees 
        has_many :user_profiles, through: :employee 
end