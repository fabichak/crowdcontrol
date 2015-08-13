class Post < ActiveRecord::Base
	belongs_to :user
	mount_uploader :image, ImageUploader
	
	scope :root, -> { where("parent_id IS NULL") }
end
