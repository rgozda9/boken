class RemoveColumn < ActiveRecord::Migration
  def change
  	remove_column :products, :avatar
  end
end
