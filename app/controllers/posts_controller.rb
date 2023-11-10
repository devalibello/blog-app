class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def destroy
    @post = Post.find(params[:id])
    @author = @post.author
    @author.decrement!(:postcounter)
    @post.destroy
    redirect_to user_posts_path(id: @author.id), notice: 'Post removed !'
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def create
    @current_user = User.find(params[:user_id])
    @post = Post.new(post_params)
    @post.commentscounter = 0
    @post.likescounter = 0
    @post.author = @current_user

    if @post.save
      redirect_to user_path(id: @current_user.id)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
