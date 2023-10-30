require 'rails_helper'
require 'spec_helper'

RSpec.describe Post, type: :request do
  let(:user) { User.create(name: 'Ali', postcounter: 0) }
  let(:post) { Post.create(author: user, title: 'Test Post', likescounter: 0, commentscounter: 0) }

  describe 'GET /users/:user_id/posts' do
    it 'render index template' do
      get "/users/#{user.id}/posts"
      expect(response.status).to eq(200)
      expect(response).to render_template('index')
      expect(response.body).to include('Display posts of user')
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    it 'render show template' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.status).to eq(200)
      expect(response).to render_template('posts/show')
      expect(response.body).to include('Show a particular post')
    end
  end
end
