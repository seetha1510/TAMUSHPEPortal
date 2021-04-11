# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search bar on XSS attack ', type: :system do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    approved_user = ApprovedEmail.new(email: 'tony@stark.com')
    approved_user.save
  end

  describe 'Successful' do
    it 'can create new profile page' do
      visit root_path
      click_on 'Sign in with Google'

      ## to do test creating new profile page
      fill_in 'Enter First Name', with: '<script>alert()</script>'
      fill_in 'Enter Last Name',  with: '<script>alert()</script>'
      click_on 'Create User profile'
      expect(page).to have_content('<script>alert()</script>')
      expect(page).to have_content('Setting')
    end

    it 'can search' do
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
      expect(page).to have_content('Yifei')
      expect(page).to have_content('Settings')
      click_link('People', match: :first)

      fill_in 'Search', with: '<script>alert()</script>'
      within('form') do
        find(:css, 'i.mx-2.fa.fa-search').click
      end
    end
  end
end
