require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'DELETE users/sign_out' do
    it 'resets the session and redirects to the sign-in page' do
      @user_zzc = FactoryBot.create(:user,provider: 'google_oauth2')
      sign_in @user_zzc
      delete :destroy

      expect(session).to be_empty
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'after_sign_out_path_for' do
    it 'returns to the sign-in page' do
      expect(controller.after_sign_out_path_for(nil)).to eq(new_user_session_path)
    end
  end

  describe 'after_sign_in_path_for' do
    before(:each) do
      @user_zzc = FactoryBot.create(:user,provider: 'google_oauth2')
      sign_in @user_zzc
    end
    it 'returns to the stored_location' do
      # manually set a store loaction
      stored_location = '/some/stored/location'
      session["user_return_to"] = stored_location
      expect(controller.after_sign_in_path_for(@user_zzc)).to eq(stored_location)
    end
    it 'returns to the root' do
      expect(controller.after_sign_in_path_for(@user_zzc)).to eq(root_path)
    end
  end
end
