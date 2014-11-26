class RemoveColumn < ActiveRecord::Migration
  def change
  	remove_column :orders, :province_name
  end
end
