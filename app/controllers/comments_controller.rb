class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :set_comment, only: [:destroy, :update]

  def create
    @comment = @item.comments.create(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to item_path(@item), notice: 'Comment has been created.'
    else
      render 'items/show', alert: 'Comment has not been created.'
    end
  end

  def update
    if @comment.user == current_user && @comment.update(comment_params)
      redirect_to item_path(@item), notice: 'Comment was successfully updated.'
    else
      render 'items/show', alert: 'Unable to update comment.'
    end
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy
      redirect_to item_path(@item), notice: 'Comment was successfully deleted.'
    else
      redirect_to item_path(@item), alert: 'You can only delete your own comments.'
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_comment
    @comment = @item.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
