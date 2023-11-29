require 'rails_helper'

RSpec.describe UsersController, type: :controller do


  describe "GET users/:id" do
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

  describe "GET users/:id/my_items" do
    it "returns all the items associated with me" do
      @user_zzc = FactoryBot.create(:user)
      sign_in @user_zzc
      @item_1 = FactoryBot.create(:item, user: @user_zzc)
      @item_2 = FactoryBot.create(:item, :title => 'title2',:detail => "this is detail about item2", user: @user_zzc, id: 2)

      @user_zzc2 = FactoryBot.create(:user,:email => "zouzhicheng2001@outlook.com", :id => 2)
      @item_5 = FactoryBot.create(:item, :title => 'title3',:detail => "this is detail about item3", user: @user_zzc2, id: 3)
      get :my_items, params: { id: 1 }
      expect(response).to render_template("my_items")
      expect(assigns[:my_items]).to eq([@item_1, @item_2])
    end
  end


end
