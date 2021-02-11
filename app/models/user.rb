class User < ApplicationRecord
     
    #Confirms primary key is user_email (check migration) 
    self.primary_key = "user_email" 

    #sets one direction relation to user_profile. if user 
    #is deleted, the user_profile will also be deleted 
    has_one :user_profile, dependent: :destroy 

    #add validations here 
    #validates :name, presence: true

end