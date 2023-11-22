class AddBuyerEmailToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :buyer_email, :string
    add_foreign_key :items, :users, column: :buyer_email, primary_key: :email
  end
end
