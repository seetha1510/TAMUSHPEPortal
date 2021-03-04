# frozen_string_literal: true

class User < ApplicationRecord
  validates :user_email, presence: true
  validates :admin_status, inclusion: { in: [true, false] }
  has_one :user_profile, dependent: :destroy
  scope :get_current_user, lambda { |current_account|
                             UserProfile.find_by(user_email: current_account.email)
                           }
end
