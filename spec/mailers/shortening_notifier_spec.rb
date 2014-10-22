require "rails_helper"

RSpec.describe ShorteningNotifier, :type => :mailer do
  describe "shortened" do
    let(:mail) do
      ShorteningNotifier.shortened(
          create(:user, email: 'yolo@dir.bg', password: 'zzzaaacc'),
          create(:shortened_url, original: 'http://a.com/',
                 shortened: 'http://b.net'))
    end

    it "renders the headers" do
      expect(mail.subject).to eq("Shortened")
      expect(mail.to).to eq(["yolo@dir.bg"])
      expect(mail.from).to eq(["proba@proba.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match /Wow!\s*
http:\/\/a\.com\/ => http:\/\/b.net\s*/
    end
  end

end
