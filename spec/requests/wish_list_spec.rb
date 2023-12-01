require 'rails_helper'


RSpec.describe WishListController, type: :controller do
  before(:each) do
    @user_zzc = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user,:email => "test@outlook.com", :id => 15)
    sign_in @user_zzc
  end

  describe '/items/:id/add_to_wish_list' do
    it 'adds an item to the wish list for the current user that is being logged in' do
      @item_1 = FactoryBot.create(:item, user: @user2)
      expect {
        post :add_to_wish_list, params: { id: @item_1.id }, format: :html
      }.to change(WishListPair, :count).by(1)
      expect(response).to redirect_to(item_path(@item_1))
      expect(flash[:notice]).to eq('Item added to wish list!')
    end

    it 'handles case when item is already in the wish list' do
      @item_1 = FactoryBot.create(:item, user: @user2)
      @wish_list_pair = FactoryBot.create(:wish_list_pair, user: @user_zzc, item: @item_1)
      expect {
        post :add_to_wish_list, params: { id: @item_1.id }, format: :html
      }.not_to change(WishListPair, :count)

      expect(response).to redirect_to(item_path(@item_1))
      expect(flash[:notice]).to eq('Item is already in the wish list.')
    end

    it 'responds to JSON format for AJAX requests' do
      @item_1 = FactoryBot.create(:item, user: @user2)
      post :add_to_wish_list, params: { id: @item_1.id }, format: :json
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Item added to wish list!')
      expect(json_response['added']).to eq(true)
    end
  end
end
