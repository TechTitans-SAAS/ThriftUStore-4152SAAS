class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :items, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :wish_list_pairs, foreign_key: 'user_id'
  has_many :wish_list_items, through: :wish_list_pairs, source: :item

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name
      user.avatar_url = auth.info.image
      #user.skip_confirmation!  # skip the confirmation emails.
    end
  end

  after_initialize :set_defaults
  def set_defaults
    address = ""
    zip_code = ""
    state = ""
    country = ""
    description = ""
  end

  def likes?(item)
    self.wish_list_items.any? and self.wish_list_items.exists?(id: item.id)
  end

  def average_item_rating
    items_with_ratings = items.where.not(rating: nil)
    return 0 if items_with_ratings.empty?
    items_with_ratings.average(:rating).to_f
  end
  # Override Devise's password_required? method
  protected
  def password_required?
    # If both the password and password_confirmation are blank, then we do not require a password.
    # Otherwise, it's required.
    return false if password.blank? && password_confirmation.blank?
    super
  end
end
