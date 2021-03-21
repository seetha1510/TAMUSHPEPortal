# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tamu ship ', type: :system do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    approvedUser = ApprovedEmail.new(email: 'tony@stark.com')
    approvedUser.save
  end

  describe 'settings page' do
    it 'shows the right content' do
      visit root_path
      click_on 'Sign in with Google'

      ## to do test creating new profile page
      fill_in 'Enter First Name', with: 'Yifei'
      fill_in 'Enter Last Name',  with: 'Liang'
      fill_in 'Enter Facebook URL', with: 'facebook.com'
      fill_in 'Enter Instagram URL', with: 'instagram.com'
      fill_in 'Enter Linkedin URL', with: 'linkedin.com'
      fill_in 'Enter Phone Number', with: '8327589525'
      fill_in 'Enter Graduating Year', with: '2022'
      click_on 'Create User profile'

      click_link('Settings', match: :first)
      expect(page).to have_content('Settings')
      expect(page).to have_content('Signed in as')
    end

    it 'goes to the right page after sign out' do
      visit root_path
      click_on 'Sign in with Google'

      ## to do test creating new profile page
      fill_in 'Enter First Name', with: 'Yifei'
      fill_in 'Enter Last Name',  with: 'Liang'
      fill_in 'Enter Facebook URL', with: 'facebook.com'
      fill_in 'Enter Instagram URL', with: 'instagram.com'
      fill_in 'Enter Linkedin URL', with: 'linkedin.com'
      fill_in 'Enter Phone Number', with: '8327589525'
      fill_in 'Enter Graduating Year', with: '2022'
      click_on 'Create User profile'
      click_link('Settings', match: :first)
      click_on 'Sign Out'

      # a = page.driver.browser.switch_to.alert
      # #expect(a.text).to eq("Signed out successfully.")
      # expect(page).to have_content('Signed out successfully.')
      expect(page).to have_content('Welcome to the memberSHPE Portal!')
    end

    it 'goes to the right page after delete my account' do
      visit root_path
      click_on 'Sign in with Google'

      ## to do test creating new profile page
      fill_in 'Enter First Name', with: 'Yifei'
      fill_in 'Enter Last Name',  with: 'Liang'
      fill_in 'Enter Facebook URL', with: 'facebook.com'
      fill_in 'Enter Instagram URL', with: 'instagram.com'
      fill_in 'Enter Linkedin URL', with: 'linkedin.com'
      fill_in 'Enter Phone Number', with: '8327589525'
      fill_in 'Enter Graduating Year', with: '2022'
      click_on 'Create User profile'
      click_link('Settings', match: :first)
      click_on 'Sign Out'
      click_on 'Sign in with Google'
      click_link('Settings', match: :first)
      click_on 'Cancel my account'
      a = page.driver.browser.switch_to.alert
      expect(a.text).to eq('Are you sure?')
      a.accept
      expect(page).to have_content('Welcome to the memberSHPE Portal!')
      # expect(page).to have_content('Bye! Your account has been successfully cancelled.')
      # subject.current_user.should be_nil
      # expect(controller.current_user).to be_nil
    end

    it 'goes to the right page after cancelling delete my account' do
      visit root_path
      click_on 'Sign in with Google'

      ## to do test creating new profile page
      fill_in 'Enter First Name', with: 'Yifei'
      fill_in 'Enter Last Name',  with: 'Liang'
      fill_in 'Enter Facebook URL', with: 'facebook.com'
      fill_in 'Enter Instagram URL', with: 'instagram.com'
      fill_in 'Enter Linkedin URL', with: 'linkedin.com'
      fill_in 'Enter Phone Number', with: '8327589525'
      fill_in 'Enter Graduating Year', with: '2022'
      click_on 'Create User profile'
      click_link('Settings', match: :first)
      click_on 'Sign Out'
      click_on 'Sign in with Google'

      click_link('Settings', match: :first)

      click_on 'Cancel my account'

      a = page.driver.browser.switch_to.alert
      expect(a.text).to eq('Are you sure?')
      a.dismiss
      expect(page).to have_content('Settings')
      expect(page).to have_content('Signed in as')
    end
  end
end
