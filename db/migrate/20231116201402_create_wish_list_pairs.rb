class CreateWishListPairs < ActiveRecord::Migration[6.1]
  def change
    create_table :wish_list_pairs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
