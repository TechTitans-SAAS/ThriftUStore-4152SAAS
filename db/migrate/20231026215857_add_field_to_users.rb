class AddFieldToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :address, :text, null: false, default: ""
    add_column :users, :zip_code, :string, null: false, default: ""
    add_column :users, :state, :string, null: false, default: ""
    add_column :users, :country, :string, null: false, default: ""
    add_column :users, :description, :text, null: false, default: ""
  end
end
