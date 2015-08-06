class Post < ActiveRecord::Base
	belongs_to :user

	scope :root, -> { where("parent_id IS NULL") }
end
