require 'rails_helper'

RSpec.describe 'User Integration', type: :system do
  before do
    @user1 = User.create(id: 100, name: 'Username 1', photo: 'test1.jpg', postcounter: 10, bio: 'User 1 bio')
    @user2 = User.create(id: 201, name: 'Username 2', photo: 'test2.jpg', postcounter: 20)
  end

  it 'redirect to the post show page' do
    post1 = Post.create(id: 103, author: @user1, title: 'Post title 1 by User 1', text: 'Post 1 by User 1', commentscounter: 0,
                        likescounter: 0)
    Comment.create(post: post1, user: @user1, text: 'User 1 sample comment 1')

    visit user_post_path(user_id: @user1.id, id: post1.id)
    sleep(5)
    expect(page).to have_content("Post ##{post1.id} by #{post1.author.name}")
    expect(page).to have_content('Likes: 0')
    expect(page).to have_content('Username 1: User 1 sample comment 1')
  end

  it 'redirect to user show page on clicking post' do
    post1 = Post.create(id: 103, author: @user1, title: 'Post title 1 by User 1', text: 'Post 1 by User 1', commentscounter: 0,
                        likescounter: 0)
    visit user_posts_path(user_id: @user1.id)
    click_link('Post 1 by User 1')
    sleep(5)
    expect(current_path).to eq(user_post_path(user_id: @user1.id, id: post1.id))
  end
end
