require 'rails_helper'

describe ShortenedUrlsController do
  describe 'show' do
    it 'should be able to show an URL by ID' do
      shortened_url = create(:shortened_url, id: 666)
      get :show, id: '666'
      expect(assigns(:shortened_url)).to eq(shortened_url)
    end

    it 'should be able to redirect properly' do
      create(:shortened_url,
             shortened: BASE_PATH + '/' + '123',
             original: 'http://dir.bg/')
      get :redirect, id: '123'
      expect(response).to redirect_to('http://dir.bg/')
    end

    it 'should return not_found if an attempt is made to redirect to a
non-existent URL' do
      expect { get :redirect, id: '123' }.to raise_error(
                                                 ActionController::RoutingError)
    end

    it 'should create new instances' do
      get :new
      expect(assigns(:shortened_url)).to be_a_new(ShortenedUrl)
    end

    it 'should save new instances' do
      allow(controller).to receive(:current_user) {
        create(:user, email: 'yolo@dir.bg', password: 'zzzaaacc')
      }
      expect do
        post :create, shortened_url: attributes_for(:shortened_url,
                                                    original: 'proba')
      end.to change(ShortenedUrl, :count).by(1)
      expect(response).to redirect_to action: :show,
                                      id: assigns(:shortened_url).id,
                                      notice: 'Yeah!'

      mail = ActionMailer::Base.deliveries[0]
      expect(mail.subject).to eq('Shortened')
      expect(mail.to).to eq(['yolo@dir.bg'])
      expect(mail.from).to eq(['proba@proba.com'])
    end

    it 'should re-render on save error' do
      allow(controller).to receive(:current_user) {
        create(:user, email: 'yolo@dir.bg', password: 'zzzaaacc')
      }
      allow_any_instance_of(ShortenedUrl).to receive(:save) { false }
      post :create, shortened_url: attributes_for(:shortened_url,
                                                  original: 'proba')
      expect(response).to render_template :new
    end
  end
end
