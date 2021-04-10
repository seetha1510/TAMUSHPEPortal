# frozen_string_literal: true

class Member < ApplicationRecord
  belongs_to :user_profile, inverse_of: :members
  belongs_to :committee
  validates :user_profile_id, presence: true, uniqueness: { scope: %i[committee_id] },
                              allow_blank: false
  validates :committee_id, presence: { message: 'Enter a Committee Name' }, allow_blank: false
end
