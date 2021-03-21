# frozen_string_literal: true

class ApprovedEmail < ApplicationRecord
  validates :email, presence: true
end
