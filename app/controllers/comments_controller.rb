class CommentsController < ApplicationController
  @user = Post.find(params[:user_id])
  @posts = @user.post
end
