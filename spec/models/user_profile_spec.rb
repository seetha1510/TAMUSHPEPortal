require 'rails_helper'

RSpec.describe UserProfile, :type => :model do

    subject {
    described_class.new(user_email: "1136692066@qq.com",
                        user_display_email_status: true,
                        user_current_member_status: true,
                        user_facebook_profile_url: "facebook.com",
                        user_instagram_profile_url: "instagram.com",
                        user_linkedin_profile_url: "linkedin.com",
                        user_graduating_year: "2018",
                        user_about_me_description: "I love video game",
                        user_phone_number: "8327581234",
                        user_first_name: "Yifei",
                        user_last_name: "Liang",
                        user_portfolio_url: "image.com"
                    )
  }
    it "is valid with valid attributes" do

        expect(subject).to be_valid
    end

    it "is not valid without a user_email" do
        subject.user_email = nil
        expect(subject).to_not be_valid
    end




    ## Facebook link Test

    it "is valid if user enter a valid facebook link " do

        expect(subject).to be_valid
    end
    it "is valid if user enter a nil facebook link " do
        subject.user_facebook_profile_url = nil
        expect(subject).to be_valid
    end
    it "is not valid if user enter a in-valid facebook link " do
        subject.user_facebook_profile_url = "asdas"
        expect(subject).to_not be_valid
    end

    ## Instagram link Test
    it "is valid if user enter a valid instagram link " do

        expect(subject).to be_valid
    end
    it "is valid if user enter a nil instagram link " do
        subject.user_instagram_profile_url = nil
        expect(subject).to be_valid
    end
    it "is not valid if user enter a in-valid instagram link " do
        subject.user_instagram_profile_url = "asdas"
        expect(subject).to_not be_valid
    end


    ## Linkedin url test
    it "is valid if user enter a valid linkedin link " do

        expect(subject).to be_valid
    end
    it "is valid if user enter a nil linkedin link " do
        subject.user_linkedin_profile_url = nil
        expect(subject).to be_valid
    end
    it "is not valid if user enter a in-valid linkedin link " do
        subject.user_linkedin_profile_url = "asdas"
        expect(subject).to_not be_valid
    end

    ## graduating year testing
    it "is valid if user enter a valid graduating year " do

        expect(subject).to be_valid
    end
    it "is valid if user enter a nil graduating year " do
        subject.user_graduating_year = nil
        expect(subject).to be_valid
    end
    it "is not valid if user enter a in-valid graduating year " do
        subject.user_graduating_year = "123"
        expect(subject).to_not be_valid
    end


    
    ## phone number test

    it "is not valid if user enter a 9 digit user_phone_number " do
        subject.user_phone_number = "213123"
        expect(subject).to_not be_valid
    end

    it "is valid if user enter a nil user_phone_number " do
        subject.user_phone_number = nil
        expect(subject).to be_valid
    end


  end
