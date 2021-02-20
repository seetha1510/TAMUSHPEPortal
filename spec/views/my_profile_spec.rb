require "rails_helper"

RSpec.describe "My Profile", type: :view do

    it "displays my profile correctly" do
        visit new_account_registration_path
        ## to get an account to log in
        fill_in "Email",	with: "yifei.liang@tamu.edu"
        fil_in "Password", with: "zx453359523"
        fill_in "Password confirmation", with: "zx453359523"
        click_on "Sign up"
            
        ## create new profile page
        fill_in "Enter First Name",	with: "Yifei"
        fill_in "Enter Last Name",	with: "Liang"
        fill_in "Enter Facebook URL" ,    with: "facebook.com"
        fill_in "Enter Instagram URL",	with: "instagram.com"
        fill_in "Enter Linkedin URL",	    with: "linkedin.com"
        fill_in "Enter Phone Number",	with: "8327589525"
        fill_in "Enter Graduating Year",	with: "2022"
        click_on "Create User profile"

        click_on "Profile"

        expect(page).to have_content("My Profile")
        expect(page).to have_button("Add")
        expect(page).to have_button("Edit")
    end
end