class WishListController < ApplicationController
  before_action :authenticate_user!

  def add_to_wish_list
    @user = current_user
    @item = Item.find(params[:id])

    unless @user.wish_list_items.exists?(id: @item.id)
      wish_list_pair = WishListPair.create(user_id: @user.id, item_id: @item.id)
      message = "Item added to wish list!"
    else
      message = "Item is already in the wish list."
    end

    respond_to do |format|
      format.html { redirect_to item_path(@item), notice: message }
      format.json { render json: { message: message, added: true } } # For AJAX requests
    end
  end

  def remove_from_wish_list
    @user = current_user
    @item = Item.find(params[:id])
    wish_list_pair = WishListPair.find_by(user_id: @user.id, item_id: @item.id)

    if wish_list_pair
      wish_list_pair.destroy
      redirect_to item_path(@item), notice: "Item removed from wish list!"
    else
      redirect_to item_path(@item), alert: "Item not found in the wish list."
    end
  end

end
