require 'rails_helper'

describe ShortenedUrlsController do
  describe "show" do
    it "should be able to show an URL by ID" do
      shortened_url = create(:shortened_url, id: 666)
      get :show, id: "666"
      expect(assigns(:shortened_url)).to eq(shortened_url)
    end

    it "should be able to redirect properly" do
      create(:shortened_url, {shortened: BASE_PATH + "/" + "123", original: "http://dir.bg/"})
      get :redirect, id: "123"
      expect(response).to redirect_to("http://dir.bg/")
    end

    it "should return not_found if an attempt is made to redirect to a non-existent URL" do
      expect {get :redirect, id: "123"}.to raise_error(ActionController::RoutingError)
    end
  end
end