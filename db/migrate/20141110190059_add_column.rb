class AddColumn < ActiveRecord::Migration
  def change
  	add_column :customers, :username, :string
  	add_column :customers, :password, :string
  end
end
