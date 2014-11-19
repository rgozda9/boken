class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :products
  has_many :lineItems

  validates :status, :customer_id, :presence => true
  validates :pst_rate, presence: true, if: "!Customer.province.pst.zero?"
  validates :gst_rate, presence: true, if: "!Customer.province.gst.zero?"
  validates :hst_rate, presence: true, if: "!Customer.province.hst.zero?"
  validates :status, format: { with: /outstanding|paid|shipped/, message: "Must be 'outstanding', 'paid' or 'shipped'"}
end
