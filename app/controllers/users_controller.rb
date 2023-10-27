class UsersController < ApplicationController
    before_action :authenticate_user!
    def profile
      @user = User.find(params[:id])
    end

    def my_items
      @user = User.find(params[:id])
      @my_items = @user.items  # assuming you have an association between users and items
    end
end
