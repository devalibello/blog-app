require 'rails_helper'

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
end
