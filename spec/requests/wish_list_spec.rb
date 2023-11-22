require 'rails_helper'

RSpec.describe "WishLists", type: :request do
  describe "GET /add_to_wish_list" do
    it "returns http success" do
      get "/wish_list/add_to_wish_list"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /remove_from_wish_list" do
    it "returns http success" do
      get "/wish_list/remove_from_wish_list"
      expect(response).to have_http_status(:success)
    end
  end

end
