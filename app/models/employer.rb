# frozen_string_literal: true

class Employer < ApplicationRecord
  has_many :employees
  has_many :user_profiles, through: :employee
  validates :employer_name, presence: true
end
