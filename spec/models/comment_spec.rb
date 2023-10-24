require_relative '../rails_helper'

RSpec.describe Comment, type: :model do
  it 'increments the comments counter for the associated post' do
    user = User.create(name: 'John')
    post = Post.create(title: 'Sample Post', commentscounter: 0, likescounter: 0, author: user)
    Comment.create(text: 'New Comment', user:, post:)
    post.reload
    expect(post.commentscounter).to eq(1)
  end
end
