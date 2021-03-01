# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employer, type: :model do
  #
  # Test Employer creation
  # with various nil inputs
  #

  subject do
    described_class.new(
      employer_name: 'Microsoft'
    )
  end

  it 'Employee is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'Employee is not valid without a user_id' do
    subject.employer_name = nil
    expect(subject).not_to be_valid
  end
end
