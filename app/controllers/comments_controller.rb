class CommentsController < ApplicationController
  def index
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
  end

  def new
    @comment = Comment.new
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @post.decrement!(:commentscounter)
    @comment.destroy!
    redirect_to user_post_comments_path(user_id: @post.author.id, post_id: @post.id),
                notice: 'Comment was successfully deleted!'
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = User.find(params[:user_id])

    if @comment.save
      redirect_to user_posts_path(user_id: @comment.user.id, post_id: @post.id)
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
