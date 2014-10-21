require 'rails_helper'
include Warden::Test::Helpers

feature 'the signin process' do
  before :each do
    Warden.test_mode!
  end

  scenario 'display a warning if already signed in' do
    login_as build(:user, email: 'user@example.com', password: 'password')
    visit '/users/sign_in'
    expect(current_path).to eq('/')
    expect(page).to have_content 'You are already signed in.'
  end
end
