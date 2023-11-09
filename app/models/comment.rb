class Comment < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_rich_text :body
end
