class AddPriceAndImageToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :price, :decimal, precision: 10, scale: 2
    add_column :items, :image, :string
  end
end
