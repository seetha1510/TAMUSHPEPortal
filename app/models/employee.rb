  
class Employee < ApplicationRecord

    self.primary_keys = "user_id", "employer_id"

    #an employee belongs to a single user_profile based on the user_id
    belongs_to :user_profile, foreign_key: "user_id"

    #an employee belongs to a single employer based on the employer_id
    belongs_to :employer, foreign_key: "employer_id"

end