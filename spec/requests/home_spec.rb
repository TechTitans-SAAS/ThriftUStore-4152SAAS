require 'rails_helper'


RSpec.describe HomeController, type: :controller do
  describe "Arrive the web with user not logged in" do
    it "show the page to log in or create account" do
      get :index
      expect(response).to have_http_status(200)
      expect(response).to render_template("index")
    end
  end
end
