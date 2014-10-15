require 'rails_helper'

describe 'ShorteningService' do
  it 'should shorten urls correctly' do
    shortened_url = build(:shortened_url, {:original => "http://dir.bg/"})
    Timecop.freeze(Time.local(2007, 3, 21, 16, 42, 18))
      ShorteningService.shorten(shortened_url)
    Timecop.return
    expect(shortened_url.shortened).to eq(BASE_PATH + "/" + "9cui1ola")
  end
end