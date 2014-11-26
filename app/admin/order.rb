ActiveAdmin.register Order do

  permit_params :status, :customer_id, :pst_rate, :hst_rate, :gst_rate, :address, :city, :country_name, :postal_code, :province_name

  index do
    column :status
    column :customer
    column :pst_rate
    column :hst_rate
    column :gst_rate
    column :address
    column :city
    column :country_name
    column :postal_code
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
