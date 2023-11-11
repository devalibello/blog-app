class UsersController < ApplicationController
  def index
    @user = User.all.includes(:comments, :posts, :likes)
  end

  def show
    @user = User.find(params[:id])
  end
end
