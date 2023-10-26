require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John', postcounter: 0) }

  it 'title valid with a title' do
    # first_user = User.first
    post = Post.new(author: user, title: 'my first post', commentscounter: 0, likescounter: 0)
    expect(post).to be_valid
  end

  it 'has no valid title' do
    post = Post.new(author: nil, commentscounter: 0, likescounter: 0)
    expect(post).not_to be_valid
  end

  it 'has no comment counter' do
    first_user = User.first
    post = Post.new(author: first_user, likescounter: 0)
    expect(post).not_to be_valid
  end

  it 'updates the postscounter after creation' do
    Post.create(
      title: 'Sample Post',
      commentscounter: 0,
      likescounter: 0,
      author: user
    )
    user.reload
    expect(user.postcounter).to eq(1)
  end

  it 'returns the first five posts with the most recent comments' do
    post = Post.create(
      title: 'Sample Post',
      commentscounter: 0,
      likescounter: 0,
      author: user
    )

    5.times do |i|
      Comment.create(text: "Comment #{i}", user:, post:, created_at: i.hours.ago)
    end

    first_five_comments = post.first_five_posts

    expect(first_five_comments.any? { |p| p.text == 'Comment 0' }).to be true
  end
end
