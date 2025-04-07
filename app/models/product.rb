class Product < ApplicationRecord
  belongs_to :category
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :category_id, presence: true

  scope :search_by_name, ->(name) {
    where("name ILIKE ?", "%#{name}%") if name.present?
  }
  scope :filter_by_category, ->(category_id) {
    where(category_id: category_id) if category_id.present?
  }

  def as_json(options = {})
    super(options.merge(methods: :category_name))
  end

  def category_name
    category&.name
  end
end
