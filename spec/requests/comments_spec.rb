# spec/controllers/comments_controller_spec.rb
require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before(:each) do
    @user_zzc = FactoryBot.create(:user)
    sign_in @user_zzc
    @item = FactoryBot.create(:item, user: @user_zzc)
    @comment = FactoryBot.create(:comment, user:@user_zzc, item: @item)
  end

  describe 'POST #create' do
    it 'creates a new comment' do
      expect do
        post :create, params: { item_id: @item.id, comment: { body: 'New comment created' } }
      end.to change(Comment, :count).by(1)
    end


    it 'redirects to the item show page on success' do
      post :create, params: { item_id: @item.id, comment: { body: 'New comment created' } }
      expect(response).to redirect_to(item_path(@item))
      expect(flash[:notice]).to eq('Comment has been created.')
    end

    it 'renders the item show page on failure' do
      allow_any_instance_of(Comment).to receive(:save).and_return(false)
      post :create, params: { item_id: @item.id, comment: { body: '' } }
      expect(response).to redirect_to(item_path(@item))
      expect(flash[:alert]).to eq('Comment has not been created.')
    end
  end


  describe 'PATCH #update' do
    it 'updates the comment' do
      patch :update, params: { item_id: @item.id, id: @comment.id, comment: { body: 'Updated comment' } }
      @comment.reload
      expect(@comment.body.to_plain_text).to eq('Updated comment')
      expect(response).to redirect_to(item_path(@item))
      expect(flash[:notice]).to eq('Comment was successfully updated.')
    end


    it 'renders the item show page on failure' do
      # create a different item
      @user_zzc2 = FactoryBot.create(:user,:email => "zouzhicheng2001@outlook.com", :id => 2)
      sign_in @user_zzc2
      patch :update, params: { item_id: @item.id, id: @comment.id, comment: { body: '' } }
      expect(response).to redirect_to(item_path(@item))
      expect(flash[:alert]).to eq('Unable to update comment.')
    end
  end


  describe 'DELETE #destroy' do
    it 'destroys the comment' do
      expect do
        delete :destroy, params: { item_id: @item.id, id: @comment.id }
      end.to change(Comment, :count).by(-1)
      expect(response).to redirect_to(item_path(@item))
      expect(flash[:notice]).to eq('Comment was successfully deleted.')
    end


    it 'redirects to the item show page with an alert if user is not the owner' do
      @user_zzc2 = FactoryBot.create(:user,:email => "zouzhicheng2001@outlook.com", :id => 2)
      sign_in @user_zzc2

      delete :destroy, params: { item_id: @item.id, id: @comment.id }
      expect(response).to redirect_to(item_path(@item))
      expect(flash[:alert]).to eq('You can only delete your own comments.')
    end
  end
end