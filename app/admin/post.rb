ActiveAdmin.register Post do
  permit_params :text, :likes, :parent_id, :user_id

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

  controller do
    def scoped_collection
      super.includes :user
    end
  end

  index do |post| 
    column :id
    column :text
    column :likes
    column :image
    column :parent_id, sortable: 'post.id'
    column :user, sortable: 'user.email'
    actions
  end

  show do |t|
    attributes_table do
      row :id 
      row :text
      row :likes
      row :parent_id
      row :user_id
      
    end
  end

  form do |f|
    f.inputs "Post" do
      f.input :text
      f.input :likes
      f.input :parent_id, :as => :select, :collection => Post.all.map {|u| [u.id, u.id]}, :include_blank => true
      f.input :user_id, :as => :select, :collection => User.all.map {|u| [u.email, u.id]}, :include_blank => true

      f.actions
    end
  end


end
