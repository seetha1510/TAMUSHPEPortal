# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'My Profile', type: :system do
  before(:each) do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    approvedUser = ApprovedEmail.new(:email => "tony@stark.com")
    approvedUser.save()
end
  it 'displays my profile correctly' do
    visit root_path
    click_on "Sign in with Google"

    ## create new profile page
    fill_in 'Enter First Name',	with: 'Yifei'
    fill_in 'Enter Last Name',	with: 'Liang'
    fill_in 'Enter Facebook URL', with: 'facebook.com'
    fill_in 'Enter Instagram URL',	with: 'instagram.com'
    fill_in 'Enter Linkedin URL', with: 'linkedin.com'
    fill_in 'Enter Phone Number',	with: '8327589525'
    fill_in 'Enter Graduating Year',	with: '2022'
    click_on 'Create User profile'

    click_link('Profile', match: :first)

    expect(page).to have_content('My Profile')

    expect(page).to have_content('Add')
    expect(page).to have_content('Edit')
  end
end
