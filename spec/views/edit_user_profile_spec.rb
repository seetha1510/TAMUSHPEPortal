# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'user profile edit page', type: :system do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    approved_user = ApprovedEmail.new(email: 'tony@stark.com')
    approved_user.save
  end
  describe 'Edit Profile Page' do
    it 'Can access the edit page' do
      visit root_path
      click_on 'Sign in with Google'

      ## to do test creating new profile page
      fill_in 'Enter First Name', with: 'Jonathan'
      fill_in 'Enter Last Name',  with: 'Gaytan'
      fill_in 'Enter Facebook URL', with: 'facebook.com'
      fill_in 'Enter Instagram URL', with: 'instagram.com'
      fill_in 'Enter Linkedin URL', with: 'linkedin.com'
      fill_in 'Enter Phone Number', with: '9562127942'
      fill_in 'Enter Graduating Year', with: '2022'
      click_on 'Create User profile'
      expect(page).to have_content('Profile')

      within '#sidebar' do
        click_on 'Profile'
      end


        click_on 'Edit Profile'

      expect(page).to have_content('Update General Information')
      visit edit_user_profile_path(UserProfile.find_by(user_id: User.find_by(user_email: 'tony@stark.com').id).id)
      expect(page).to have_content('Update General Information')
    end

    it 'can edit general information' do
      visit root_path
      click_on 'Sign in with Google'

      ## to do test creating new profile page
      fill_in 'Enter First Name', with: 'Jonathan'
      fill_in 'Enter Last Name',  with: 'Gaytan'
      fill_in 'Enter Facebook URL', with: 'facebook.com'
      fill_in 'Enter Instagram URL', with: 'instagram.com'
      fill_in 'Enter Linkedin URL', with: 'linkedin.com'
      fill_in 'Enter Phone Number', with: '9562127942'
      fill_in 'Enter Graduating Year', with: '2022'
      click_on 'Create User profile'
      expect(page).to have_content('Profile')
      visit edit_user_profile_path(UserProfile.find_by(user_id: User.find_by(user_email: 'tony@stark.com').id).id)
      expect(page).to have_content('Update General Information')
      fill_in 'Enter Facebook URL', with: 'facebook.com/jonathan'
      fill_in 'Enter Instagram URL', with: 'instagram.com/jonathan'
      fill_in 'Enter Linkedin URL', with: 'linkedin.com/jonathan'
      fill_in 'Enter Portfolio URL', with: 'jonathangaytan.com'
      click_on 'Update User profile'
    end

    it 'cannot edit general information with no first name' do
      visit root_path
      click_on 'Sign in with Google'

      ## to do test creating new profile page
      fill_in 'Enter First Name', with: 'Jonathan'
      fill_in 'Enter Last Name',  with: 'Gaytan'
      fill_in 'Enter Facebook URL', with: 'facebook.com'
      fill_in 'Enter Instagram URL', with: 'instagram.com'
      fill_in 'Enter Linkedin URL', with: 'linkedin.com'
      fill_in 'Enter Phone Number', with: '9562127942'
      fill_in 'Enter Graduating Year', with: '2022'
      click_on 'Create User profile'
      expect(page).to have_content('Profile')
      visit edit_user_profile_path(UserProfile.find_by(user_id: User.find_by(user_email: 'tony@stark.com').id).id)
      expect(page).to have_content('Update General Information')
      fill_in 'Enter First Name', with: ''
      click_on 'Update User profile'
      expect(page).to have_content('Enter Your First Name')
    end

    it 'cannot edit general information with no last name' do
      visit root_path
      click_on 'Sign in with Google'

      ## to do test creating new profile page
      fill_in 'Enter First Name', with: 'Jonathan'
      fill_in 'Enter Last Name',  with: 'Gaytan'
      fill_in 'Enter Facebook URL', with: 'facebook.com'
      fill_in 'Enter Instagram URL', with: 'instagram.com'
      fill_in 'Enter Linkedin URL', with: 'linkedin.com'
      fill_in 'Enter Phone Number', with: '9562127942'
      fill_in 'Enter Graduating Year', with: '2022'
      click_on 'Create User profile'
      expect(page).to have_content('Profile')
      visit edit_user_profile_path(UserProfile.find_by(user_id: User.find_by(user_email: 'tony@stark.com').id).id)
      expect(page).to have_content('Update General Information')
      fill_in 'Enter Last Name', with: ''
      click_on 'Update User profile'
      expect(page).to have_content('Enter Your Last Name')
    end

    it 'cannot edit general information with invalid facebook URL' do
      visit root_path
      click_on 'Sign in with Google'

      ## to do test creating new profile page
      fill_in 'Enter First Name', with: 'Jonathan'
      fill_in 'Enter Last Name',  with: 'Gaytan'
      fill_in 'Enter Facebook URL', with: 'facebook.com'
      fill_in 'Enter Instagram URL', with: 'instagram.com'
      fill_in 'Enter Linkedin URL', with: 'linkedin.com'
      fill_in 'Enter Phone Number', with: '9562127942'
      fill_in 'Enter Graduating Year', with: '2022'
      click_on 'Create User profile'
      expect(page).to have_content('Profile')
      visit edit_user_profile_path(UserProfile.find_by(user_id: User.find_by(user_email: 'tony@stark.com').id).id)
      expect(page).to have_content('Update General Information')
      fill_in 'Enter Facebook URL', with: 'faceboo.com'
      click_on 'Update User profile'
      expect(page).to have_content('Use a Valid Facebook URL')
    end

    it 'cannot edit general information with invalid Instagram URL' do
      visit root_path
      click_on 'Sign in with Google'

      ## to do test creating new profile page
      fill_in 'Enter First Name', with: 'Jonathan'
      fill_in 'Enter Last Name',  with: 'Gaytan'
      fill_in 'Enter Facebook URL', with: 'facebook.com'
      fill_in 'Enter Instagram URL', with: 'instagram.com'
      fill_in 'Enter Linkedin URL', with: 'linkedin.com'
      fill_in 'Enter Phone Number', with: '9562127942'
      fill_in 'Enter Graduating Year', with: '2022'
      click_on 'Create User profile'
      expect(page).to have_content('Profile')
      visit edit_user_profile_path(UserProfile.find_by(user_id: User.find_by(user_email: 'tony@stark.com').id).id)
      expect(page).to have_content('Update General Information')
      fill_in 'Enter Instagram URL', with: 'insta.com'
      click_on 'Update User profile'
      expect(page).to have_content('Use a Valid Instagram URL')
    end

    it 'cannot edit general information with invalid Linkedin URL' do
      visit root_path
      click_on 'Sign in with Google'

      ## to do test creating new profile page
      fill_in 'Enter First Name', with: 'Jonathan'
      fill_in 'Enter Last Name',  with: 'Gaytan'
      fill_in 'Enter Facebook URL', with: 'facebook.com'
      fill_in 'Enter Instagram URL', with: 'instagram.com'
      fill_in 'Enter Linkedin URL', with: 'linkedin.com'
      fill_in 'Enter Phone Number', with: '9562127942'
      fill_in 'Enter Graduating Year', with: '2022'
      click_on 'Create User profile'
      expect(page).to have_content('Profile')
      visit edit_user_profile_path(UserProfile.find_by(user_id: User.find_by(user_email: 'tony@stark.com').id).id)
      expect(page).to have_content('Update General Information')
      fill_in 'Enter Linkedin URL', with: 'link.com'
      click_on 'Update User profile'
      expect(page).to have_content('Use a Valid Linkedin URL')
    end

    it 'cannot edit general information with all invalid inputs together' do
      visit root_path
      click_on 'Sign in with Google'

      ## to do test creating new profile page
      fill_in 'Enter First Name', with: 'Jonathan'
      fill_in 'Enter Last Name',  with: 'Gaytan'
      fill_in 'Enter Facebook URL', with: 'facebook.com'
      fill_in 'Enter Instagram URL', with: 'instagram.com'
      fill_in 'Enter Linkedin URL', with: 'linkedin.com'
      fill_in 'Enter Phone Number', with: '9562127942'
      fill_in 'Enter Graduating Year', with: '2022'
      click_on 'Create User profile'
      expect(page).to have_content('Profile')
      visit edit_user_profile_path(UserProfile.find_by(user_id: User.find_by(user_email: 'tony@stark.com').id).id)
      expect(page).to have_content('Update General Information')
      fill_in 'Enter First Name', with: ''
      fill_in 'Enter Last Name', with: ''
      fill_in 'Enter Facebook URL', with: 'faceboo.com'
      fill_in 'Enter Instagram URL', with: 'insta.com'
      fill_in 'Enter Linkedin URL', with: 'link.com'
      click_on 'Update User profile'
      expect(page).to have_content('Enter Your First Name')
      expect(page).to have_content('Enter Your Last Name')
      expect(page).to have_content('Use a Valid Facebook URL')
      expect(page).to have_content('Use a Valid Instagram URL')
      expect(page).to have_content('Use a Valid Linkedin URL')
    end
  end
end
