class PostsController < ApplicationController
  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
  	@post.user_id = current_user.id
  	if @post.save
  		flash[:success] = "Post created"
  		redirect_to posts_path(@post)
  	else
  		flash[:error] = "Error!"
  		render 'new'
  	end
  end

  def index
  	@posts = Post.all
  end

  private

  	def post_params
  		params.require(:post).permit(:title, :body, :user_id)
  	end
end
