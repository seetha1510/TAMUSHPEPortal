# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'employee edit page', type: :system do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    approved_user = ApprovedEmail.new(email: 'tony@stark.com')
    approved_user.save
  end

  it 'displays the edit employee form correctly' do
    visit root_path
    click_on 'Sign in with Google'

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
    click_link('Add', match: :first)

    fill_in 'Company *', with: 'Microsoft'
    fill_in 'Title *', with: 'Software Engineer'
    fill_in 'City *', with: 'Missouri City'
    fill_in 'State *', with: 'Texas'
    click_on 'Add'

    find(:css, 'i.fa.fa-edit.fa-lg').click

    expect(page).to have_field('Company *')
    expect(page).to have_field('Title *')
    expect(page).to have_button('Update')
  end

  it 'updates an employee upon submitting' do
    visit root_path
    click_on 'Sign in with Google'

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
    click_link('Add', match: :first)

    fill_in 'Company *', with: 'Microsoft'
    fill_in 'Title *', with: 'Software Engineer'
    fill_in 'City *', with: 'Missouri City'
    fill_in 'State *', with: 'Texas'
    click_on 'Add'

    find(:css, 'i.fa.fa-edit.fa-lg').click

    fill_in 'Company *', with: 'Google'
    fill_in 'Title *', with: 'Software Engineer'
    fill_in 'City *', with: 'Missouri City'
    fill_in 'State *', with: 'Texas'
    click_on 'Update'
    expect(page).to have_content('Google')
  end

  it 'redirects to the correct page after updating' do
    visit root_path
    click_on 'Sign in with Google'

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
    click_link('Add', match: :first)

    fill_in 'Company *', with: 'Microsoft'
    fill_in 'Title *', with: 'Software Engineer'
    fill_in 'City *', with: 'Missouri City'
    fill_in 'State *', with: 'Texas'
    click_on 'Add'

    find(:css, 'i.fa.fa-edit.fa-lg').click

    fill_in 'Company *', with: 'Google'
    fill_in 'Title *', with: 'Software Engineer'
    fill_in 'City *', with: 'Missouri City'
    fill_in 'State *', with: 'Texas'
    click_on 'Update'
    expect(page).to have_content('My Profile')
  end
end
