class PostsController < ApplicationController
	acts_as_token_authentication_handler_for User, only: [:new_post]
	before_filter :set_default_response_format
	skip_before_action :verify_authenticity_token

	def list
		@posts = Post.all
	end

	def detail
		@posts = Post.where(parent_id: params[:id])
	end

	def new_post
		respond_to do |format|
			format.json { render :json=> {:success=>true} }
		end
	end

	def set_default_response_format
		request.format = :json
	end
end
