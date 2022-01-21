class PostsController < ApplicationController
	before_action :ensure_logged_in
	before_action :is_user_the_author?, only:[:edit, :update]

	def new
		@post = Post.new
		render :new
	end

	def show
		@post = Post.find_by(id: params[:id])
		render :show
	end

	def create
		@post = Post.new(post_params)
		@post.sub_id = params[:sub_id]
		@post.user_id = current_user.id

		if @post.save
			redirect_to post_url(@post)
		else
			flash.now[:errors] = @post.errors.full_messages
			render :new
		end
	end

	def edit
		@post = Post.find(params[:id])

		if @post && is_user_the_author?	
		else
			flash.now[:error] = ["User is not the author of the post"]
		end

		render :edit
	end

	def update
		@post = Post.find(params[:id])

		if @post.update(post_params)
			redirect_to post_url(@post)
		else
			flash.now[:errors] = @post.errors.full_messages
			render :edit
		end
	end

	def is_user_the_author?
		@post.user_id == current_user.id
	end

	private

	def post_params
		params.require(:post).permit(:title, :url, :content)
	end
end
