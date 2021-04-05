# frozen_string_literal: true

class Committee < ApplicationRecord
  has_many :members
  has_many :user_profiles, through: :member
  validates :committee_name, presence: true, uniqueness: true
end
