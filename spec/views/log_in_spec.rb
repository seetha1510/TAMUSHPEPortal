require "rails_helper"
RSpec.describe 'TAMU SHPE', type: :system do
    describe 'log in page' do
      it 'shows the right content' do
        visit new_account_session_path
        expect(page).to have_content('Email')
        click_on "Log in"
        expect(page).to have_content('Log In')
      end

      it 'allows log in' do
        visit new_account_registration_path
        ## to get an account to log in
        fill_in "Email",    with: "jonathan09@tamu.edu"
        fill_in "Password", with: "Hello123!"
        fill_in "Password confirmation", with: "Hello123!"
        click_on "Sign up"
        
        ## to do test creating new profile page
        fill_in "Enter First Name", with: "Jonathan"
        fill_in "Enter Last Name",  with: "Gaytan"
        fill_in "Enter Facebook URL" ,    with: "facebook.com"
        fill_in "Enter Instagram URL",  with: "instagram.com"
        fill_in "Enter Linkedin URL",       with: "linkedin.com"
        fill_in "Enter Phone Number",   with: "9562127942"
        fill_in "Enter Graduating Year",    with: "2022"
        click_on "Create User profile"
        visit setting_path
        click_on "Sign Out"
        visit new_account_session_path
        expect(page).to have_content('Email')
        click_on "Log in"
        expect(page).to have_content('Log In')
        fill_in "Email",    with: "jonathan09@tamu.edu"
        fill_in "Password",    with: "Hello123!"
        click_on "Log in"
        expect(page).to have_content('Welcome, Jonathan')
      end

      it 'doesnt allow log in with no email' do
        visit new_account_session_path
        expect(page).to have_content('Email')
        click_on "Log in"
        expect(page).to have_content('Log In')
        fill_in "Email",    with: ""
        fill_in "Password",    with: "Hello123!"
        click_on "Log in"
        expect(page).to have_content('Invalid Email or password.')
      end

      it 'doesnt allow log in with no password' do
        visit new_account_session_path
        expect(page).to have_content('Email')
        click_on "Log in"
        expect(page).to have_content('Log In')
        fill_in "Email",    with: "jonathan09@tamu.edu"
        fill_in "Password",    with: ""
        click_on "Log in"
        expect(page).to have_content('Invalid Email or password.')
      end

      it 'doesnt allow log in with no email or password' do
        visit new_account_session_path
        expect(page).to have_content('Email')
        click_on "Log in"
        expect(page).to have_content('Log In')
        fill_in "Email",    with: ""
        fill_in "Password",    with: ""
        click_on "Log in"
        expect(page).to have_content('Invalid Email or password.')
      end
    end
end