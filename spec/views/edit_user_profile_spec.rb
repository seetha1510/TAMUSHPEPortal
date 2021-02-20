require "rails_helper"

RSpec.describe "user profile edit page", type: :view do
    
    #
    # Test user profile edit form funcitonality
    #

    it "displays the edit user profile form correctly" do
        visit employee_path(User.get_current_user(current_account).user_id)

        expect(page).to have_content('My Profile')
        expect(page).to have_content('General Information')
        expect(page).to have_content('Positions')
        expect(page).to have_content('Edit')
        expect(page).to have_content('Add')
    end

    it "updates user profile upon submitting valid information" do
        visit edit_user_profile_path

        fill_in "Facebook", with: "www.facebook.com/test"
        fill_in "Graduating Year", with: "2021"
        click_on "Update User Profile"

        expect(UserProfile.find(current_account.email).user).to eq("Microsoft")
        expect(Employee.last.employee_position).to eq("Software Engineer")
    end

    it "redirects the correct page upon submitting" do
        visit new_employee_path

        fill_in "Employer Name", with: "Google"
        fill_in "Position", with: "Software Engineer"
        click_on "Create Employee"

        expect(page).to have_content("My Profile")
        expect(page).to have_content("General Information")
        expect(page).to have_content("Positions")
    end
end