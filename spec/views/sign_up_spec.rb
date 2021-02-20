require "rails_helper"

RSpec.describe 'Tamu ship ', type: :system do
    describe 'sign up page' do
      it 'shows the right content' do
        visit new_account_registration_path
        
        expect(page).to have_content('Email')
        expect(page).to have_content('Password (6 characters minimum)')
        expect(page).to have_content('Password confirmation')
      end
      it 'goes to the right page after sign up' do
        visit new_account_registration_path

        fill_in "Email",    with: "yifei.liang@tamu.edu"
        fill_in "Password", with: "zx453359523"
        fill_in "Password confirmation", with: "zx453359523"
        click_on "Sign up"
        expect(page).to have_content('Facebook')
      end
    end
      
    describe "New Profile Page" do
        it 'shows the right content' do
            visit new_account_registration_path
            ## to get an account to log in
            fill_in "Email",    with: "yifei.liang@tamu.edu"
            fill_in "Password", with: "zx453359523"
            fill_in "Password confirmation", with: "zx453359523"
            click_on "Sign up"
            
            expect(page).to have_content('First Name')
            expect(page).to have_content('Last Name')
            expect(page).to have_content('Email Address')
            expect(page).to have_content('Current Member')
            expect(page).to have_content('Hide Email')
            expect(page).to have_content('Facebook')
            expect(page).to have_content('Instagram')
            expect(page).to have_content('Linkedin')
            expect(page).to have_content('Portfolio')
            expect(page).to have_content('Image')
            expect(page).to have_content('Phone Number')
            expect(page).to have_content('About Me')
            expect(page).to have_content('Graduating Year')
        end

        it 'can create new profile page' do
            visit new_account_registration_path
            ## to get an account to log in
            fill_in "Email",    with: "yifei.liang@tamu.edu"
            fill_in "Password", with: "zx453359523"
            fill_in "Password confirmation", with: "zx453359523"
            click_on "Sign up"
            
            ## to do test creating new profile page
            fill_in "Enter First Name", with: "Yifei"
            fill_in "Enter Last Name",  with: "Liang"
            fill_in "Enter Facebook URL" ,    with: "facebook.com"
            fill_in "Enter Instagram URL",  with: "instagram.com"
            fill_in "Enter Linkedin URL",       with: "linkedin.com"
            fill_in "Enter Phone Number",   with: "8327589525"
            fill_in "Enter Graduating Year",    with: "2022"
            click_on "Create User profile"
            expect(page).to have_content('Yifei')
            expect(page).to have_content('Setting')
            
        end

        it 'go back to create new profile page after failing' do
            visit new_account_registration_path
            ## to get an account to log in
            fill_in "Email",    with: "yifei.liang@tamu.edu"
            fill_in "Password", with: "zx453359523"
            fill_in "Password confirmation", with: "zx453359523"
            click_on "Sign up"
            
            ## to do test creating new profile page
            fill_in "Enter First Name", with: "Yifei"
            fill_in "Enter Last Name",  with: "Liang"
            fill_in "Enter Facebook URL" ,    with: "faceasdasdbook.com"
            fill_in "Enter Instagram URL",  with: "instagram.com"
            fill_in "Enter Linkedin URL",       with: "linkedin.com"
            fill_in "Enter Phone Number",   with: "8327589525"
            fill_in "Enter Graduating Year",    with: "2022"
            click_on "Create User profile"
            expect(page).to have_content('First Name')

            
        end
            
            
    end
    
  end
