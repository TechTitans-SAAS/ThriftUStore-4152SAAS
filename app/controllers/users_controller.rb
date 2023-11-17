class UsersController < ApplicationController
    before_action :authenticate_user!
    def profile
      @user = User.find(params[:id])
    end



    def my_items
      @user = User.find(params[:id])
      @my_items = @user.items  # assuming you have an association between users and items
    end
    
    def show_wish_list
      @user = User.find(params[:id])
      @wish_list_items = @user.wish_list_items
    end
end
