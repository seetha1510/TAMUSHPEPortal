class UserProfile < ApplicationRecord

    #override id attribute name 
    self.primary_key = "user_id" 

    #a user profile belongs to a user.  
    #the relationship is referenced by the foreign_key "user_email" in the user_profiles table 
    #use belongs_to bc this table has the foreign key 
    belongs_to :user, foreign_key: "user_email"

    #set up the associative entity "employee"
    #should use the through: when extra attributes are needed on the relationship
    has_many :employees
    has_many :employers, through: :employees

end