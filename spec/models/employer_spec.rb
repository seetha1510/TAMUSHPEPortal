require 'rails_helper'

RSpec.describe Employer, :type => :model do

    #
    # Test Employer creation 
    # with various nil inputs
    #
    
    subject {

        described_class.new(
            employer_name: "Microsoft"
        )
    }

    it "Employee is valid with valid attributes" do
        expect(subject).to be_valid
    end

    it "Employee is not valid without a user_id" do
        subject.employer_name = nil
        expect(subject).to_not be_valid
    end
end