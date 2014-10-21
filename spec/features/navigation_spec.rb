require 'rails_helper'

feature 'navigation' do
  before :each do
    build(:user, email: 'user@example.com', password: 'password')
  end

  scenario 'navigates to sign in page properly' do
    visit '/'
    click_link 'Sign in'
    expect(page).to have_content 'Log in'
    expect(current_path).to eq('/users/sign_in')
  end
end
