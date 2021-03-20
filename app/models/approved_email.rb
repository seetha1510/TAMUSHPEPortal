class ApprovedEmail < ApplicationRecord
    validates :email, presence: true
end
