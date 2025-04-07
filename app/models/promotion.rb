class Promotion < ApplicationRecord
  has_many :product_promotions
  has_many :products, through: :product_promotions

  validates :title, presence: true
  validates :discount_type, presence: true, inclusion: { in: [ "percentage", "fixed_amount" ], message: "%{value} is not a valid discount type" }
  validates :discount_value, presence: true, numericality: { greater_than: 0 }
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date
  validates :discount_value, numericality: { less_than_or_equal_to: 100 }, if: -> { discount_type == "percentage" }

  def end_date_after_start_date
    if end_date.present? && start_date.present? && end_date <= start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

  def active_now?
    start_date <= Time.current && end_date >= Time.current
  end
end
