# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Employee, type: :model do
  #
  # Test Employee creation
  # with various nil inputs
  #

  subject do
    described_class.new(
      user_id: 1,
      employer_id: 1,
      employee_position: 'Software Engineer'
    )
  end

  it 'Employee is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'Employee is not valid without a user_id' do
    subject.user_id = nil
    expect(subject).not_to be_valid
  end

  it 'Employee is not valid without a employer_id' do
    subject.employer_id = nil
    expect(subject).not_to be_valid
  end

  it 'Employee is not valid without a employee_position' do
    subject.employee_position = nil
    expect(subject).not_to be_valid
  end
end
