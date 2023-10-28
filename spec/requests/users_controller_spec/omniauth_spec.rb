require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'POST #google_oauth2' do

    context 'when Google OAuth2 authentication is successful' do
      it 'signs in the user and redirects' do
        auth_hash = OmniAuth.config.mock_auth[:google_oauth2] # 获取模拟的 OAuth2 数据
        request.env['omniauth.auth'] = auth_hash
        post :google_oauth2
        expect(response).to redirect_to(root_path)
        expect(subject.current_user).not_to be_nil
      end
    end

    context 'when Google OAuth2 authentication fails' do
      it 'redirects to the sign-in page with an error message' do
        auth_hash = OmniAuth::AuthHash.new(provider: 'google_oauth2', uid: 'zz3105', info: { email: 'zz3105@columbia.edu' })
        # let the user to be null
        allow(User).to receive(:from_omniauth).and_return(nil)
        request.env['omniauth.auth'] = auth_hash
        post :google_oauth2
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end

