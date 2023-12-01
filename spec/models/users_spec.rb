require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#likes?' do
    before(:each) do
      @user = FactoryBot.create(:user, :email => "test@test.com",:id => 4)
      @item = FactoryBot.create(:item, :title => 'title',:detail => "this is detail about item", user: @user, id: 1, price: 9)
      @item2 = FactoryBot.create(:item, :title => 'title2',:detail => "this is detail about item2", user: @user, id: 10, price: 9)
    end


    context 'when user likes the item' do
      before { @user.wish_list_items << @item }
      it 'returns true' do
        expect(@user.likes?(@item)).to be true
        expect(@user.likes?(@item2)).to be false
      end
    end

    context 'when user does not like the item' do
      it 'returns false' do
        expect(@user.likes?(@item)).to be false
      end
    end
  end

  describe "calculate the average rates of the user " do
    it 'correctly return the average rates' do
      @user5 = FactoryBot.create(:user, :email => "test5@test.com",:id => 5)
      @item11 = FactoryBot.create(:item, :title => 'title',:detail => "this is detail about item", user: @user5, id: 11, price: 9, rating:5)
      @item12 = FactoryBot.create(:item, :title => 'title',:detail => "this is detail about item", user: @user5, id: 12, price: 9, rating: 3)
      @item13 = FactoryBot.create(:item, :title => 'title',:detail => "this is detail about item", user: @user5, id: 13, price: 9)
      expect(@user5.average_item_rating).to eq(4)

    end
  end
end