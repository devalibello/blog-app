class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'user', foreign_key: 'author_id'
  after_create :post_counter

  def post_counter
    author.update(postcounter: author.posts.count)
  end

  def first_five_posts
    comments.order(created_at: :desc).limit(5)
  end
end
