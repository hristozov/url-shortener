require 'rails_helper'

feature "the signin process" do
  before :each do
    build(:user, {:email => 'user@example.com', :password => 'password'})
  end

  scenario "signs me in" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end