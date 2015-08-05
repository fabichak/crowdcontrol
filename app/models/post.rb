class Post < ActiveRecord::Base
	scope :root, -> { where("parent_id IS NULL") }
end
