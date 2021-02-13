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

    it "is not valid if user enter a 9 digit user_phone_number " do
        subject.user_phone_number = "213123"
        expect(subject).to_not be_valid
    end

    it "is not valid if user enter a nil user_phone_number " do
        subject.user_phone_number = nil
        expect(subject).to be_valid
    end


  end
