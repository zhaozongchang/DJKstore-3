class Product < ApplicationRecord
  is_impressionable
  mount_uploader :image, ImageUploader
  validates :title, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
end
