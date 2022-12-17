class Product < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :image_url, presence: true, image: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

end


