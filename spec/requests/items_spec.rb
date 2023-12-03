require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  before(:each) do
    @user_zzc = FactoryBot.create(:user)
    sign_in @user_zzc
    @item_1 = FactoryBot.create(:item, user: @user_zzc)
    @item_2 = FactoryBot.create(:item, :title => 'title2',:detail => "this is detail about item2", user: @user_zzc, id: 2, price: 9)
    @item_3 = FactoryBot.create(:item, :title => 'title3',:detail => "this is detail about item3", user: @user_zzc, id: 3, price: 1)
    @item_4 = FactoryBot.create(:item, :title => 'title4',:detail => "this is detail about item4", user: @user_zzc, id: 4, price: 8)
    @user_zzc2 = FactoryBot.create(:user,:email => "zouzhicheng2001@outlook.com", :id => 2)
    @item_5 = FactoryBot.create(:item, :title => 'title5',:detail => "this is detail about item5", user: @user_zzc2, id: 5, price: 4, buyer: @user_zzc)
  end

  describe "Get /items" do
    it "returns all the items associated to all users without any query parameters" do
      get :index
      expect(assigns[:items]).to eq([@item_1, @item_2, @item_3, @item_4, @item_5])
      expect(response).to render_template("index")
    end

    context "returns results based on the query" do
      it "query on item title" do
        get :index, params: { search: @item_2.title }
        expect(assigns(:items)).to include(@item_2)
      end
      it "query on item detail" do
        get :index, params: { search: "this is detail about" }
        expect(assigns[:items]).to eq([@item_1, @item_2, @item_3, @item_4, @item_5])
      end
    end

    context "with the sort parameters presented" do
      it "sorts based on directions and sort" do
        get :index, params: { sort: 'price', direction: 'desc' }
        expect(assigns(:items)).to eq([@item_2, @item_4, @item_5, @item_1, @item_3])
      end
    end

    context "sorts based on owner_rating and desc - no item is rated" do
      it "sorts based on owner_rating and desc" do
        get :index, params: { sort: 'owner_rating', direction: 'desc' }
        expect(assigns(:items)).to eq([@item_1, @item_2, @item_3, @item_4, @item_5])
      end
    end

    context "sorts based on owner_rating and desc - rating by owner's score" do
      it "sorts based on owner_rating and desc if the owner does not have rating yet, just leave it on the back of the result" do
        @item_6 = FactoryBot.create(:item, :title => 'title6',:detail => "this is detail about item6", user: @user_zzc2, id: 6, price: 12, buyer: @user_zzc, rating: 4)
        @item_7 = FactoryBot.create(:item, :title => 'title7',:detail => "this is detail about item7", user: @user_zzc2, id: 7, price: 7, buyer: @user_zzc, rating: 5)
        @user_zzc3 = FactoryBot.create(:user,:email => "test@outlook.com", :id => 3)
        @item_8 = FactoryBot.create(:item, :title => 'title8',:detail => "this is detail about item8", user: @user_zzc3, id: 8, price: 12, buyer: @user_zzc2, rating: 3)
        get :index, params: { sort: 'owner_rating', direction: 'desc' }
        expect(assigns(:items)).to eq([@item_7, @item_6, @item_8, @item_1, @item_2, @item_3, @item_4, @item_5])
      end
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


  describe "mark item as sold /items/:id/mark_as_sold" do
    it 'updates the item successfully and redirects to the item path' do
      put :mark_as_sold, params: {id:2, item: {buyer_email: 'zouzhicheng2001@outlook.com'} }
      @item_2.reload
      expect(@item_2.buyer.email).to eq 'zouzhicheng2001@outlook.com'

      expect(response).to redirect_to(item_path(@item_2))
    end


    it 'update failed case -  buyer email not exist in database' do
      put :mark_as_sold, params: {id:2, item: {buyer_email: 'zouzhicheng2001@outasdlook.com'} }
      @item_2.reload
      expect(flash[:alert]).to eq "Invalid Email address!"
      expect(response).to redirect_to(item_path(@item_2))
    end

    it 'update failed case -  buyer email not passed to controller' do
      put :mark_as_sold, params: {id:2, item: {title: 'newtitle'} }
      @item_2.reload
      expect(flash[:alert]).to eq "You should input an Email!"
    end

    it 'update failed case -  universal case' do
      allow_any_instance_of(Item).to receive(:save).and_return(false)
      put :mark_as_sold, params: {id:2, item: {buyer_email: 'zouzhicheng2001@outlook.com'} }
      @item_2.reload
      expect(flash[:alert]).to eq "Failed to mark item as sold."
    end



  end

  describe "/items/:id/update_rating" do
    context 'successfully update the rating' do
      it 'updates the item rating and redirects to the item path' do
        @item_rating = FactoryBot.create(:item, :title => 'title2',:detail => "this is detail about item2", user: @user_zzc, id: 6, price: 9)
        put :update_rating, params: { id: @item_rating.id, rating: 4 }
        @item_rating.reload
        expect(@item_rating.rating).to eq(4)
        expect(response).to redirect_to(item_path(@item_rating))
      end
    end
  end
end


