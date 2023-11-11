require 'rails_helper'
# integration tests for posts a users
RSpec.describe 'User Integration', type: :system do
  before do
    @user1 = User.create(id: 100, name: 'Username 1', photo: 'test1.jpg', postcounter: 10, bio: 'User 1 bio')
    @user2 = User.create(id: 201, name: 'Username 2', photo: 'test2.jpg', postcounter: 20)
  end

  it 'displays a list of users' do
    visit users_path
    expect(page).to have_content('Username 1')
    expect(page).to have_content('Username 2')
    find("img[src='test1.jpg']")
    find("img[src='test2.jpg']")
    expect(page).to have_content('Number of posts: 10')
    expect(page).to have_content('Number of posts: 20')
  end

  it 'redirects to the user show page when clicking on a user' do
    visit users_path
    click_link('Username 1')
    sleep(5)
    expect(current_path).to eq(user_path(id: @user1.id))
  end

  it 'displays user details on the user show page' do
    visit user_path(@user1)
    expect(page).to have_content('Username 1')
    find("img[src='test1.jpg']")
    expect(page).to have_content('Number of posts: 10')
    expect(page).to have_content('User 1 bio')
  end

  it 'display users first 3 posts' do
    Post.create(id: 103, author: @user1, title: 'Post title 1 by User 1',
                text: 'Post 1 by User 1', commentscounter: 0, likescounter: 0)
    Post.create(author: @user1, title: 'Post title 2 by User 1',
                text: 'Post 2 by User 1', commentscounter: 0, likescounter: 0)
    Post.create(author: @user1, title: 'Post title 3 by User 1',
                text: 'Post 3 by User 1', commentscounter: 0, likescounter: 0)
    visit user_path(@user1)
    sleep(5)
    expect(page).to have_content('Post 1 by User 1')
    expect(page).to have_content('Post 2 by User 1')
    expect(page).to have_content('Post 3 by User 1')
    expect(page).to have_css('a.see-more', count: 1)
  end

  it 'redirects to see all user posts' do
    visit user_path(@user1)
    click_link('See all posts')
    sleep(5)
    expect(current_path).to eq(user_posts_path(user_id: @user1.id))
  end

  it 'display user post index page' do
    post1 = Post.create(id: 105, author: @user1, title: 'Post title 1 by User 1',
                        text: 'Post 1 by User 1', commentscounter: 0, likescounter: 0)
    post2 = Post.create(id: 106, author: @user1, title: 'Post title 2 by User 1',
                        text: 'Post 2 by User 1', commentscounter: 0, likescounter: 0)
    Comment.create(post: post1, user: @user1, text: 'User 1 sample comment 1')
    Comment.create(post: post1, user: @user2, text: 'User 2 sample comment 1')
    Comment.create(post: post2, user: @user1, text: 'User 1 sample comment 1')
    Comment.create(post: post2, user: @user2, text: 'User 2 sample comment 1')
    visit user_posts_path(user_id: @user1.id)
    sleep(5)
    expect(page).to have_content('Username 1')
    find("img[src='test1.jpg']")
    expect(page).to have_content('User 1 sample comment 1')
    expect(page).to have_content('Comments: 2')
    expect(page).to have_content('Likes: 0')
    expect(page).to have_content('Pagination')
  end

  it 'redirect to the post show page' do
    post1 = Post.create(id: 103, author: @user1, title: 'Post title 1 by User 1',
                        text: 'Post 1 by User 1', commentscounter: 0, likescounter: 0)
    Comment.create(post: post1, user: @user1, text: 'User 1 sample comment 1')

    visit user_post_path(user_id: @user1.id, id: post1.id)
    sleep(5)
    expect(page).to have_content("Post ##{post1.id} by #{post1.author.name}")
    expect(page).to have_content('Likes: 0')
    expect(page).to have_content('Username 1: User 1 sample comment 1')
  end

  it 'redirect to user show page on clicking post' do
    post1 = Post.create(id: 103, author: @user1, title: 'Post title 1 by User 1',
                        text: 'Post 1 by User 1', commentscounter: 0, likescounter: 0)
    visit user_posts_path(user_id: @user1.id)
    click_link('Post 1 by User 1')
    sleep(5)
    expect(current_path).to eq(user_post_path(user_id: @user1.id, id: post1.id))
  end
end
