# spec/hello_world_spec.rb

require 'rails_helper'

RSpec.describe 'Hello World', type: :system do
  it 'index page' do
    visit hello_world_index_path
    expect(page).to have_content('Hello world')
  end
end