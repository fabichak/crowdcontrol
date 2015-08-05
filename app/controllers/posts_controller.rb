class PostsController < ApplicationController
  def list
  	@posts = Post.all
  end

  def detail
  	@posts = Post.where(parent_id: params[:id])
  end
end
