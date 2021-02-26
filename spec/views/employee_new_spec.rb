require "rails_helper"

RSpec.describe "employee new page", type: :system do
    
    #
    # Test new employee form funcitonality
    #

    it "displays the add employee form correctly" do
        visit new_account_registration_path
        ## to get an account to log in
        fill_in "Email",	with: "yifei.liang@tamu.edu"
        fill_in "Password", with: "zx453359523"
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

        
        visit new_employee_path

        expect(page).to have_field('Employer Name')
        expect(page).to have_field('Position')
        expect(page).to have_button('Create Employee')
    end

    it "creates an employee upon submitting" do
        visit new_account_registration_path
        ## to get an account to log in
        fill_in "Email",	with: "yifei.liang@tamu.edu"
        fill_in "Password", with: "zx453359523"
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

        click_link("Profile", match: :first)
        click_on "Add"

        fill_in "Employer Name", with: "Microsoft"
        fill_in "Position", with: "Software Engineer"
        click_on "Create Employee"

        expect(page).to have_content("Microsoft")
        expect(page).to have_content("Software Engineer")
    end

    it "redirects the correct page upon submitting" do
        visit new_account_registration_path
        ## to get an account to log in
        fill_in "Email",	with: "yifei.liang@tamu.edu"
        fill_in "Password", with: "zx453359523"
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

        click_link("Profile", match: :first)
        click_on "Add"

        fill_in "Employer Name", with: "Google"
        fill_in "Position", with: "Software Engineer"
        click_on "Create Employee"

        expect(page).to have_content("My Profile")
        expect(page).to have_content("General Information")
        expect(page).to have_content("Positions")
    end
end