class Product < ApplicationRecord
  is_impressionable
  acts_as_list
  mount_uploader :image, ImageUploader
  validates :title, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
end
