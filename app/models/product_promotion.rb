class ProductPromotion < ApplicationRecord
  belongs_to :product
  belongs_to :promotion

  validates :product_id, presence: true
  validates :promotion_id, presence: true
  validates :product_id, uniqueness: { scope: :promotion_id, message: "Product has already been assigned to this promotion" }
end
