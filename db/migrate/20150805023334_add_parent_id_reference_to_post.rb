class AddParentIdReferenceToPost < ActiveRecord::Migration
  def change
  	add_column :posts, :parent_id, :integer, references: :posts
  end
end
