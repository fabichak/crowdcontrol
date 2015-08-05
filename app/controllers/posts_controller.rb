class PostsController < ApplicationController
  def list
  	@posts = Post.root
  end

  def detail
  	@post = Post.find(params[:id])
  end
end
