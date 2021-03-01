# frozen_string_literal: true

RSpec.describe User, type: :model do
  #
  # Test User creation
  #

  subject do
    described_class.new(
      user_email: 'test123@gmail.com',
      admin_status: true
    )
  end

  it 'User is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'User is not valid without a user_email' do
    subject.user_email = nil
    expect(subject).not_to be_valid
  end

  it 'User is not valid without an admin_status' do
    subject.admin_status = nil
    expect(subject).not_to be_valid
  end
end
