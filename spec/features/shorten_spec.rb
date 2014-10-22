require 'rails_helper'
include Warden::Test::Helpers

feature 'the shortening process' do
  before :each do
    Warden.test_mode!
  end

  scenario 'do not allow shortening for a unregisterd user' do
    visit '/'

    expect(current_path).to eq('/')
    expect(page).to have_css('input#shortened_url_original[disabled]')
    expect(page).to have_css('input.btn[disabled]')
    expect(page.find('input#shortened_url_original')[:placeholder])
    .to eq('Log in first!')
  end

  scenario 'allow shortening for a unregisterd user' do
    login_as create(:user, email: 'lol@dir.bg', password: '12345678')
    visit '/'

    expect(current_path).to eq('/')
    expect(page).to_not have_css('input#shortened_url_original[disabled]')
    expect(page).to_not have_css('input.btn[disabled]')
    expect(page.find('input#shortened_url_original')[:placeholder])
    .to eq('Your URL')
  end

  scenario 'shorten URLs properly' do
    login_as create(:user, email: 'lol@dir.bg', password: '12345678')
    visit '/'
    within('.input-group') do
      fill_in 'shortened_url[original]', with: 'http://hit.bg/'
    end
    Timecop.freeze(Time.local(2007, 3, 21, 16, 42, 18)) do
      click_button 'Shorten!'
    end

    expect(current_path).to eq('/shortened_urls/1')
    expect(page).to have_css('input#from-url')
    expect(page).to have_css('input#to-url')
    expect(page.find('input#from-url')[:value]).to eq('http://hit.bg/')
    expect(page.find('input#to-url')[:value])
    .to eq('http://localhost:3000/redirect/9cuif51a')

    mail = ActionMailer::Base.deliveries[0]
    expect(mail.subject).to eq('Shortened')
    expect(mail.to).to eq(['yolo@dir.bg'])
    expect(mail.from).to eq(['proba@proba.com'])
  end
end
