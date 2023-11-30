class UsersController < ApplicationController
    before_action :authenticate_user!
    def profile
      @user = User.find(params[:id])
      @average_rating = @user.average_item_rating
    end

    def my_items
      @user = User.find(params[:id])
      @my_items = @user.items  # assuming you have an association between users and items
    end

    def show_wish_list
      @user = User.find(params[:id])

      if current_user == @user
        @wish_list_items = @user.wish_list_items
        render 'show_wish_list'
      else
        flash[:alert] = "You are not authorized to view this wishlist."
        redirect_to user_wish_list_path(current_user)
      end
    end

end
