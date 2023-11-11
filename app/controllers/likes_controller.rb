class LikesController < ApplicationController
  def create
    @like = @current_user.likes.build(post: find_post)
    
    if @like.save
      redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id]), notice: 'Post liked!'
    else
      redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id]), alert: 'Unable to like the post.'
    end
  end

  private

  def find_post
    Post.find(params[:post_id])
  end
end
