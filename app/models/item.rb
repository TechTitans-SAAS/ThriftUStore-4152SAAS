class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image # if using Active Storage for image uploading
  validates :image, presence: true
  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  validates :detail, presence: true, length: { minimum: 10 } # requiring a minimum length for descriptions
  validates :price, presence: true, numericality: { greater_than: 0 }
  has_many :comments, dependent: :destroy
end
