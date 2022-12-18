class Product < ApplicationRecord
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :image_url, presence: true, image: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  private
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base,'Line Items present')
      throw :abort
    end
  end
end


