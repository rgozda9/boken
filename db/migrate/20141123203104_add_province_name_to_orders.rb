class AddProvinceNameToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :province_name, :string
  end
end
