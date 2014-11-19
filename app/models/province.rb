class Province < ActiveRecord::Base
  has_many :customers

  validates :name, :pst, :gst, :hst, :presence => true
  validates :pst, format: { with: /0\.[0-9]+/,
  message: "value must be in this format: 0.##" }, if: "!pst.zero?"
  validates :gst, format: { with: /0\.[0-9]+/,
  message: "value must be in this format: 0.##" }, if: "!gst.zero?"
  validates :hst, format: { with: /0\.[0-9]+/,
  message: "value must be in this format: 0.##" }, if: "!hst.zero?"
end