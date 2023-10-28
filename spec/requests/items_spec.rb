require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  before(:each) do
    @user_zzc = FactoryBot.create(:user)
    sign_in @user_zzc
    @item_1 = FactoryBot.create(:item, user: @user_zzc)
    @item_2 = FactoryBot.create(:item, :title => 'title2',:detail => "this is detail about item2", user: @user_zzc, id: 2)
    @item_3 = FactoryBot.create(:item, :title => 'title3',:detail => "this is detail about item3", user: @user_zzc, id: 3)
    @item_4 = FactoryBot.create(:item, :title => 'title4',:detail => "this is detail about item4", user: @user_zzc, id: 4)
    @user_zzc2 = FactoryBot.create(:user,:email => "zouzhicheng2001@outlook.com", :id => 2)
    @item_5 = FactoryBot.create(:item, :title => 'title5',:detail => "this is detail about item5", user: @user_zzc2, id: 5)
  end

  describe "Get /items" do
    it "returns all the items associated to all users" do
      get :index
      expect(assigns[:items]).to eq([@item_1, @item_2, @item_3, @item_4, @item_5])
      expect(response).to render_template("index")
    end
  end

  describe "Get /items/:id" do
    it "gets the specific item with a specific id" do
      get :show, params: { id: 1 }
      expect(assigns[:item]).to eq(@item_1)
      expect(response).to render_template("show")
    end
  end

  describe "Get /items/new" do
    it "renders the form to allow users to create a new item" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "Get /items/:id/edit" do
    it "get the page to edit the specific item" do
      get :edit,  params: { id: 1 }
      expect(assigns[:item]).to eq(@item_1)
      expect(response).to render_template("edit")
    end
  end

  describe "Post /items" do
    it "create new item and saved via html" do
      image_file = fixture_file_upload( 'spec/features/files/image.jpeg', 'image/jpeg')
      item_params = { title: 'title6', detail: 'this is detail about item6', image:image_file, price: 4 }
      post :create, params: { item: item_params }
      expect(response).to redirect_to item_url(6)
    end
    it "create new item and saved via json" do
      image_file = fixture_file_upload( 'spec/features/files/image.jpeg', 'image/jpeg')
      item_params = { title: 'title6', detail: 'this is detail about item6',image:image_file, price: 4}
      post :create, format: :json, params: { item: item_params }
      expect(response).to have_http_status(:created)
    end

    it "create new item and but not saved into database via html" do
      item_params = { title: 'title6', detail: 'this is detail about item6' }
      allow_any_instance_of(Item).to receive(:save).and_return(false)
      post :create, params: { item: item_params }
      expect(response).to render_template("new")
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it "create new item and but not saved into database via json" do
      item_params = { title: 'title6', detail: 'this is detail about item6' }
      allow_any_instance_of(Item).to receive(:save).and_return(false)
      post :create, format: :json, params: { item: item_params }
      expect(response).to have_http_status(:unprocessable_entity)
    end

  end

  describe "Put /items/:id" do
    it "update a specific item via HTML successfully" do
      updated_attributes = { title: 'updated_title_1', detail: 'this is updated detail about item1' }
      put :update,  params: { id: 1, item: updated_attributes }
      expect(response).to redirect_to item_url(1)
      expect(flash[:notice]).not_to eq(nil)
    end
    it "update a specific item via JSON successfully" do
      updated_attributes = { title: 'updated_title_1', detail: 'this is updated detail about item1' }
      put :update,  params: { id: 1, item: updated_attributes,format: :json }
      expect(response).to render_template("show")
      expect(response).to have_http_status(:ok)
      expect(response.headers['Location']).to eq(item_url(@item_1))
    end

    it "update a specific item via HTML NOT UPDATED" do
      updated_attributes = { title: 'updated_title_1', detail: 'this is updated detail about item1' }
      allow_any_instance_of(Item).to receive(:update).and_return(false)
      put :update,  params: { id: 1, item: updated_attributes }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:edit)
    end
    it "update a specific item via JSON NOT UPDATED" do
      updated_attributes = { title: 'updated_title_1', detail: 'this is updated detail about item1' }
      allow_any_instance_of(Item).to receive(:update).and_return(false)
      put :update,  params: { id: 1, item: updated_attributes,format: :json }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /items/:id" do
    it "get the page to edit the specific item" do
      delete :destroy, params: { id: 1 }
      expect(Item.exists?(1)).to be_falsey
      expect(response).to redirect_to(user_my_items_path(@user_zzc))
      expect(flash[:notice]).to eq('Item was successfully destroyed.')
    end
  end

end


