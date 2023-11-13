# spec/controllers/search_controller_spec.rb
require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns a Ransack query to @query' do
      get :index
      expect(assigns(:query)).to be_a Ransack::Search
    end

    it 'assigns search results to @items' do
      @user_zzc = FactoryBot.create(:user)
      sign_in @user_zzc
      @item_1 = FactoryBot.create(:item, user: @user_zzc)
      @item_2 = FactoryBot.create(:item, :title => 'title2',:detail => "this is detail about item2", user: @user_zzc, id: 2)
      get :index, params: { q: { name_cont: @item_2.title } }
      expect(assigns(:items)).to include(@item_2)
    end


    it 'no corresponding search result should return all items already exist' do
      @user_zzc = FactoryBot.create(:user)
      sign_in @user_zzc
      @item_1 = FactoryBot.create(:item, user: @user_zzc)
      @item_2 = FactoryBot.create(:item, :title => 'title2',:detail => "this is detail about item2", user: @user_zzc, id: 2)
      get :index, params: { q: { name_cont: 'title3' } }
      expect(assigns(:items)).to eq([@item_1, @item_2])
    end
  end
end
