class PostsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
  	@post.user_id = current_user.id
  	if @post.save
  		flash[:success] = "Post created"
  		redirect_to posts_path
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
      flash[:success] = "Post updated succesfully"
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

    def signed_in_user
      unless signed_in?
        flash[:error] = "Please login"
        redirect_to login_path
      end

    end
end
