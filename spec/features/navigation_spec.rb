require 'rails_helper'
include Warden::Test::Helpers

feature 'navigation' do
  before :each do
    Warden.test_mode!
  end

  def expect_active_link(link)
    expect(page.all('li.active').count).to eq(1)
    expect(page.find('li.active > a')[:href]).to eq(link)
  end

  scenario 'marks properly the home page active button' do
    visit '/'
    expect_active_link('/')
  end

  scenario 'navigates to sign in page properly' do
    visit '/'
    click_link 'Sign in'
    expect(page).to have_content 'Log in'
    expect(current_path).to eq('/users/sign_in')
  end

  scenario 'navigates to my links properly' do
    login_as create(:user, email: 'ggg@ggg.net', password: '12345678', id: 17)

    visit '/'
    click_link 'My links'
    expect(page).to have_text 'Your email is ggg@ggg.net'
    expect(page).to have_text 'Your ID is 17'
    expect(current_path).to eq('/users/me')

    expect_active_link('/users/me')
  end

  scenario 'logs out the user properly' do
    login_as create(:user, email: 'ggg@ggg.net', password: '12345678', id: 17)

    visit '/'
    expect(page).to have_text 'My links'
    click_link 'Sign out'
    expect(page).to have_text 'Signed out successfully.'
    expect(page).to_not have_text 'My links'
    expect(page).to have_text 'Sign in'
    expect(current_path).to eq('/')
  end
end
