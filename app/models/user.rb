class User < ApplicationRecord
    self.primary_key = "user_email"
    has_one :user_profile, dependent: :destroy
end