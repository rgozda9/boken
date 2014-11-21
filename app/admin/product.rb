ActiveAdmin.register Product do

  permit_params :name, :description, :price, :stock_quantity, :status, :on_sale, :rating, :genre, :category_id, :image
  
  form :html => { :enctype => 'multipart/form-data' } do |f|
    f.inputs "Details", :multipart => true do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :status
      f.input :on_sale
      f.input :rating
      f.input :genre
      f.input :category
      f.input :image
    end
    f.actions
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
