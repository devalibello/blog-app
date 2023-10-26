require_relative '../rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John') }
  let(:post) { Post.create(title: 'Sample Post', commentscounter: 0, likescounter: 0, author: user) }

  it 'updates the likescounter after creating a like' do
    Like.create(user:, post:)
    post.reload
    expect(post.likescounter).to eq(1)
  end
end
