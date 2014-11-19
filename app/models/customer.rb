class Customer < ActiveRecord::Base
  belongs_to :province
  has_many :orders

  validates :first_name, :last_name, :address, :city, :country_name, :postal_code, :email, :province, :username, :password, :presence => true
  validates :email, :username, :uniqueness => true
  validates :postal_code, format: { with: /[ABCEGHJKLMNPRSTVXY]{1}\d{1}[ABCEGHJKLMNPRSTVWXYZ]{1}\s *\d{1}[ABCEGHJKLMNPRSTVWXYZ]{1}\d{1}/, message: "Must be in this format: A1B 2C3" }
  validates :email, format: { with: /[\w\.-_\+!#\$%&'\*\/=\?\^`\{\}\|~:\(\)\,:;<>@\[\]\"]+@[\w-]+(\.\w{2,4})+/, message: "Must be a valid email address"}

  def full_name
    "#{first_name} #{last_name}"
  end
end
