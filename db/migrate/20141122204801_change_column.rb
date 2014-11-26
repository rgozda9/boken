class ChangeColumn < ActiveRecord::Migration
  def change
  	change_column :orders, :province, :integer
  end
end
