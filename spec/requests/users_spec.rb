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

  describe '#show_wish_list' do
    context 'when user is authorized' do
      it 'renders the show_wish_list template and get all the wish list items of the user' do
        @user_zzc_test = FactoryBot.create(:user,:email => "test_wishlist@outlook.com", :id => 11)
        @user_zzc_2_test = FactoryBot.create(:user,:email => "test_wishlist2@outlook.com", :id => 12)
        @item_1 = FactoryBot.create(:item, user: @user_zzc_2_test, id:13)
        @item_2 = FactoryBot.create(:item, :title => 'title2',:detail => "this is detail about item2", user: @user_zzc_2_test, id: 12)
        @wish_list_pair = FactoryBot.create(:wish_list_pair, :user => @user_zzc_test, :item => @item_1)
        sign_in @user_zzc_test

        get :show_wish_list, params: { id: @user_zzc_test.id }
        expect(response).to render_template('show_wish_list')
        expect(assigns(:user)).to eq(@user_zzc_test)
        expect(assigns(:wish_list_items)).to eq(@user_zzc_test.wish_list_items)
        expect(assigns(:wish_list_items)).to eq([@item_1])
      end
    end

    context 'when user is not authorized' do
      it 'redirects to the current user\'s wish list with an alert' do
        @user_zzc_test = FactoryBot.create(:user,:email => "test_wishlist@outlook.com", :id => 11)
        @user_zzc_2_test = FactoryBot.create(:user,:email => "test_wishlist2@outlook.com", :id => 12)
        sign_in @user_zzc_test
        get :show_wish_list, params: { id: @user_zzc_2_test.id }

        expect(response).to redirect_to(user_wish_list_path(@user_zzc_test))
        expect(flash[:alert]).to eq("You are not authorized to view this wishlist.")
      end
    end
  end


end
