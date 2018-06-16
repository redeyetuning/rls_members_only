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

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.update_attributes(post_params)
      flash[:sucess] = "Post updated succesfully"
      redirect_to post
    else
      flash[:error] = "Update error, please try again"
      render 'edit'  
    end 
  end

  private

  	def post_params
  		params.require(:post).permit(:title, :body, :user_id)
  	end
end
