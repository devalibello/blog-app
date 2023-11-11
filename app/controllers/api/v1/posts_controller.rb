module Api
  module V1
    class PostsController < ApplicationController
      def index
        user = User.find(params[:user_id])
        render json: user.posts
      end
    end
  end
end
