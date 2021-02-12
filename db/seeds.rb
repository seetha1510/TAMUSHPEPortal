# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user1 = User.create(user_email: 'fakeuser1@email',
            admin_status: false)

user2 = User.create(user_email: 'fakeuser2@email',
            admin_status: true)

UserProfile.create!(user_email: user1[:user_email],
                user_display_email_status: true,
                user_current_member_status: true,
                user_facebook_profile_url: "facebook.com",
                user_instagram_profile_url: "instagram.com",
                user_linkedin_profile_url: "linkedin.com",
                user_graduating_year: 2021,
                user_about_me_description: "",
                user_phone_number: "9729849423",
                user_first_name: 'jason',
                user_last_name: "gilman",
                user_portfolio_url: "",
                user_profile_picture_url: "")

UserProfile.create!(user_email: user2[:user_email],
                user_display_email_status: true,
                user_current_member_status: false,
                user_facebook_profile_url: "facebook.com",
                user_instagram_profile_url: "instagram.com",
                user_linkedin_profile_url: "linkedin.com",
                user_graduating_year: 2010,
                user_about_me_description: "",
                user_phone_number: "2149878885",
                user_first_name: 'abcfirst',
                user_last_name: "abclast",
                user_portfolio_url: "",
                user_profile_picture_url: "")

Employer.create(employer_description: "Microsoft", employer_industry: "tech")
Employer.create(employer_description: "Google", employer_industry: "tech")