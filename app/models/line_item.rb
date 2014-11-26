class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  validates :quantity, :price, :product_id, :order_id, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0,
                                       only_integer: true }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
end
