ActiveAdmin.register Customer do

  permit_params :first_name, :last_name, :address, :city, :country_name, :postal_code, :email, :province_id, :username, :password

  index do
    column :first_name
    column :last_name
    column :address
    column :city
    column :country_name
    column :postal_code
    column :email
    column :province
    column :username
    column :password
    actions
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

end
