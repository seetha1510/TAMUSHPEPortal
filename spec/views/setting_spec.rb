# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tamu ship ', type: :system do
  describe 'settings page' do
    it 'shows the right content' do
      visit new_account_registration_path
      fill_in 'Email',    with: 'yifei.liang@tamu.edu'
      fill_in 'Password', with: 'zx453359523'
      fill_in 'Password confirmation', with: 'zx453359523'
      click_on 'Sign up'

      ## to do test creating new profile page
      fill_in 'Enter First Name', with: 'Yifei'
      fill_in 'Enter Last Name',  with: 'Liang'
      fill_in 'Enter Facebook URL', with: 'facebook.com'
      fill_in 'Enter Instagram URL', with: 'instagram.com'
      fill_in 'Enter Linkedin URL', with: 'linkedin.com'
      fill_in 'Enter Phone Number', with: '8327589525'
      fill_in 'Enter Graduating Year', with: '2022'
      click_on 'Create User profile'

      visit setting_path
      expect(page).to have_content('Settings')
      expect(page).to have_content('Signed in as')
    end

    it 'goes to the right page after sign out' do
      visit new_account_registration_path
      fill_in 'Email',    with: 'yifei.liang@tamu.edu'
      fill_in 'Password', with: 'zx453359523'
      fill_in 'Password confirmation', with: 'zx453359523'
      click_on 'Sign up'

      ## to do test creating new profile page
      fill_in 'Enter First Name', with: 'Yifei'
      fill_in 'Enter Last Name',  with: 'Liang'
      fill_in 'Enter Facebook URL', with: 'facebook.com'
      fill_in 'Enter Instagram URL', with: 'instagram.com'
      fill_in 'Enter Linkedin URL', with: 'linkedin.com'
      fill_in 'Enter Phone Number', with: '8327589525'
      fill_in 'Enter Graduating Year', with: '2022'
      click_on 'Create User profile'
      visit setting_path
      click_on 'Sign Out'

      # a = page.driver.browser.switch_to.alert
      # #expect(a.text).to eq("Signed out successfully.")
      # expect(page).to have_content('Signed out successfully.')
      expect(page).to have_content('Welcome to the memberSHPE Portal!')
    end

    it 'goes to the right page after delete my account' do
      visit new_account_registration_path
      fill_in 'Email',    with: 'yifei.liang@tamu.edu'
      fill_in 'Password', with: 'zx453359523'
      fill_in 'Password confirmation', with: 'zx453359523'
      click_on 'Sign up'

      ## to do test creating new profile page
      fill_in 'Enter First Name', with: 'Yifei'
      fill_in 'Enter Last Name',  with: 'Liang'
      fill_in 'Enter Facebook URL', with: 'facebook.com'
      fill_in 'Enter Instagram URL', with: 'instagram.com'
      fill_in 'Enter Linkedin URL', with: 'linkedin.com'
      fill_in 'Enter Phone Number', with: '8327589525'
      fill_in 'Enter Graduating Year', with: '2022'
      click_on 'Create User profile'
      visit setting_path
      click_on 'Sign Out'
      visit account_session_path
      fill_in 'Email',    with: 'yifei.liang@tamu.edu'
      fill_in 'Password', with: 'zx453359523'
      click_on 'Log in'
      visit setting_path
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
      visit new_account_registration_path
      fill_in 'Email',    with: 'yifei.liang@tamu.edu'
      fill_in 'Password', with: 'zx453359523'
      fill_in 'Password confirmation', with: 'zx453359523'
      click_on 'Sign up'

      ## to do test creating new profile page
      fill_in 'Enter First Name', with: 'Yifei'
      fill_in 'Enter Last Name',  with: 'Liang'
      fill_in 'Enter Facebook URL', with: 'facebook.com'
      fill_in 'Enter Instagram URL', with: 'instagram.com'
      fill_in 'Enter Linkedin URL', with: 'linkedin.com'
      fill_in 'Enter Phone Number', with: '8327589525'
      fill_in 'Enter Graduating Year', with: '2022'
      click_on 'Create User profile'
      visit setting_path
      click_on 'Sign Out'
      visit account_session_path
      fill_in 'Email',    with: 'yifei.liang@tamu.edu'
      fill_in 'Password', with: 'zx453359523'
      click_on 'Log in'
      visit setting_path
      click_on 'Cancel my account'
      a = page.driver.browser.switch_to.alert
      expect(a.text).to eq('Are you sure?')
      a.dismiss
      expect(page).to have_content('Settings')
      expect(page).to have_content('Signed in as')
    end
  end
end
