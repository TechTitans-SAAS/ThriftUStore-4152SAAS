class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  
  def create
    @comment = @item.comments.create(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to item_path(@item), notice: 'Comment has been created'
    else
      redirect_to item_path(@item), alert: 'Comment has not been created'
    end
  end

  def destroy
    @comment = @item.comments.find(params[:id])
    @comment.destroy
    redirect_to item_path(@item)
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
