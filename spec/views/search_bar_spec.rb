# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search bar ', type: :system do
  describe 'Successful' do
    it 'can create new profile page' do
      visit new_account_registration_path
      ## to get an account to log in
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
      expect(page).to have_content('Yifei')
      expect(page).to have_content('Setting')
      click_link('People', match: :first)

      fill_in 'Search', with: 'Yifei'
      click_on 'Search'
      expect(page).to have_content('Yifei')
    end
  end
end
