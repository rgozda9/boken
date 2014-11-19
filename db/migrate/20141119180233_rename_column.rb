class RenameColumn < ActiveRecord::Migration
  def change
  	rename_column :customers, :country, :country_name
  end
end
