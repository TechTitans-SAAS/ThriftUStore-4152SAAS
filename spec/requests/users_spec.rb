require 'rails_helper'

RSpec.describe UsersController, type: :controller do


  describe "#profile" do
    it 'authenticated user should see the profile page' do
      @user_zzc = FactoryBot.create(:user)
      sign_in @user_zzc
      get :profile, params: { id: 1 }
      expect(response).to render_template("profile")
    end
    it 'unauthenticated user should return to the signin page' do
      @user_zzc = FactoryBot.create(:user)
      get :profile, params: { id: 1 }
      expect(response).to redirect_to '/users/sign_in'
    end

  end
end
