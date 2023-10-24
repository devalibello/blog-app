require_relative '../rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a name and a non-negative post counter' do
    user = User.new(name: 'John', postcounter: 5)
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = User.new(postcounter: 5)
    expect(user).not_to be_valid
  end

  it 'is not valid with a negative post counter' do
    user = User.new(name: 'Alice', postcounter: -1)
    expect(user).not_to be_valid
  end

  it 'is valid with a zero post counter' do
    user = User.new(name: 'Bob', postcounter: 0)
    expect(user).to be_valid
  end

  it 'should return the 3 most recent posts for a given user' do
    user = User.create(id: 40, name: 'Ali', postcounter: 3)
    5.times do
      post = user.posts.build(title: 'I love my life', commentscounter: 0, likescounter: 0)
      post.author_id = user.id
      user.save!
      post.save!
    end
    expect(user.three_most_recent_posts.length).to eq(3)
  end
end
