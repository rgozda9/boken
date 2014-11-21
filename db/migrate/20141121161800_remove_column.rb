class RemoveColumn < ActiveRecord::Migration
  def change
  	remove_column :customers, :password_confirmation
  end
end
