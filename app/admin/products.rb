ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :description, :price, :mrp, :image
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :price, :mrp]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  remove_filter :orders

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :price
      f.input :mrp
      f.input :image, as: :file
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :price
    column :mrp
    column :image do |obj|
      obj.image.attached? ? (image_tag url_for(obj&.image), style: 'height: 40px; width: 50px;') : "no image"
    end 
    actions
  end

  show do 
    attributes_table do 
      row :title
      row :description
      row :price
      row :mrp 
      row :image do |obj|
      obj.image.attached? ? (image_tag url_for(obj&.image), style: 'height: 300px; width: 350px;') : "no image"
      end
    end 
  end

  
end
