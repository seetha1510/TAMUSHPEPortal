require "rails_helper"

RSpec.describe "employee new page", type: :view do
    
    #
    # Test new employee form funcitonality
    #

    it "displays the add employee form correctly" do
        visit new_employee_path

        expect(page).to have_field('Employer Name')
        expect(page).to have_field('Position')
        expect(page).to have_button('Create Employee')
    end

    it "creates an employee upon submitting" do
        visit new_employee_path

        fill_in "Employer Name", with: "Microsoft"
        fill_in "Position", with: "Software Engineer"
        click_on "Create Employee"

        expect(Employer.find(Employee.last.employer_id)).to eq("Microsoft")
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