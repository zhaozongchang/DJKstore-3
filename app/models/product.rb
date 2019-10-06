class Product < ApplicationRecord
  is_impressionable
  acts_as_list
  mount_uploader :image, ImageUploader

  has_many :photos
  has_many :reviews
  belongs_to :category
  accepts_nested_attributes_for :photos
end
