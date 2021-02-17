class User < ApplicationRecord
    self.primary_key = "user_email"
    has_one :user_profile, dependent: :destroy

    scope :get_current_user, ->(current_account) {UserProfile.where(user_email:current_account.email).first}
end