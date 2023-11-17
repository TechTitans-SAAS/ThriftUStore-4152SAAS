class WishListController < ApplicationController
  before_action :authenticate_user!
  
  def add_to_wish_list
    user = current_user
    item = Item.find(params[:id])

    # Check if the item is already in the wish list to avoid duplicates
    unless user.wish_list_items.exists?(id: item.id)
      wish_list_pair = WishListPair.create(user_id: user.id, item_id: item.id)
      flash[:notice] = "Item added to wish list!"
    else
      flash[:alert] = "Item is already in the wish list."
    end
  end

  def remove_from_wish_list
    user = current_user
    item = Item.find(params[:id])

    # Find the WishListItem associated with the user and item
    wish_list_pair = WishListPair.find_by(user_id: user.id, item_id: item.id)

    if wish_list_pair
      # If the WishListItem exists, destroy it
      wish_list_pair.destroy
      flash[:notice] = "Item removed from wish list!"
    else
      flash[:alert] = "Item not found in the wish list."
    end
  end
  
end
