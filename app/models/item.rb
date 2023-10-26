class Item < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  validates :detail, presence: true
end
