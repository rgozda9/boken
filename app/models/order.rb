class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :products
  has_many :lineItems, :dependent => :delete_all

  validates :status, :customer_id, :address, :city, :province, :country_name, :postal_code,
            :pst_rate, :gst_rate, :hst_rate, presence: true
  validates :status, format: { with: /outstanding|paid|shipped/,
                               message: "Must be 'outstanding', 'paid' or
                               'shipped'" }
  validates :postal_code, format: { with: /[ABCEGHJKLMNPRSTVXY]{1}\d{1}[ABCEGHJKLMNPRSTVWXYZ]{1}\s+\d{1}[ABCEGHJKLMNPRSTVWXYZ]{1}\d{1}/,
                                    message: 'Must be in this format: A1B 2C3' }
end
