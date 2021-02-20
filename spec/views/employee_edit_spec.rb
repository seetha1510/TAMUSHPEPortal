require "rails_helper"

RSpec.describe "employee edit page", type: :view do

    it "displays the edit employee form correctly" do
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
        click_on "Add"

        fill_in "Employer Name", with: "Microsoft"
        fill_in "Position", with: "Software Engineer"
        click_on "Create Employee"

        visit edit_employee_path(1)

        expect(page).to have_field('Employer Name')
        expect(page).to have_field('Position')
        expect(page).to have_button('Update Employee')
    end


    it "updates an employee upon submitting" do
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
        click_on "Add"

        fill_in "Employer Name", with: "Microsoft"
        fill_in "Position", with: "Software Engineer"
        click_on "Create Employee"

        visit edit_employee_path(1)

        fill_in "Employer Name", with: "Google"
        fill_in "Position", with: "Software Engineer"
        click_on "Update Employee"

        expect(Employer.find(Employee.last.employer_id)).to eq("Google")
    end

    it "redirects to the correct page after updating" do
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
        click_on "Add"

        fill_in "Employer Name", with: "Microsoft"
        fill_in "Position", with: "Software Engineer"
        click_on "Create Employee"

        visit edit_employee_path(1)

        fill_in "Employer Name", with: "Google"
        fill_in "Position", with: "Software Engineer"
        click_on "Update Employee"

        expect(page).to have_content("My Profile")
    end

end