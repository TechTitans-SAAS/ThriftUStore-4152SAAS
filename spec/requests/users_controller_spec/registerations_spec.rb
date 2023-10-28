require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'PUT #update' do
    it 'updates the user profile with GoogleAuthen' do
      @user_zzc = FactoryBot.create(:user,provider: 'google_oauth2')
      sign_in @user_zzc
      user_params = { email: 'new_email@example.com'}
      controller.update_resource(@user_zzc, user_params)
      expect(@user_zzc.email).to eq('new_email@example.com')
    end

    it 'updates the user profile with password' do
      @user_zzc = FactoryBot.create(:user)
      sign_in @user_zzc
      user_params = { email: 'new_email@example.com', password: 'password' }
      controller.update_resource(@user_zzc, user_params)
      expect(@user_zzc.email).to eq('new_email@example.com')
      expect(@user_zzc.valid_password?('password')).to be_truthy
    end

  end
end

