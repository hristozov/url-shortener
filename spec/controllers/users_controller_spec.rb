require 'rails_helper'

describe UsersController do
  describe 'show_profile' do
    it 'should bla' do
      user = create(:user,
                    email: 'ddd@dir.bg',
                    password: 'zzzaaacc',
                    id: 7)
      allow(controller).to receive(:current_user)
                           .and_return(user)
      create(:shortened_url, id: 1, user_id: 2)
      url2 = create(:shortened_url, id: 2, user_id: 7)
      create(:shortened_url, id: 3, user_id: 1)
      url4 = create(:shortened_url, id: 4, user_id: 7)

      get :show_profile
      expect(assigns[:user]).to eq(user)
      expect(assigns[:shortened_urls]).to eq([url2, url4])
      expect(response).to render_template :show_profile
    end
  end
end
