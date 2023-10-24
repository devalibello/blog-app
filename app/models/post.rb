class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  after_create :post_counter
  validates :commentscounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likescounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :title, presence: true, length: { maximum: 250 }

  def post_counter
    author.update(postcounter: author.posts.count)
  end

  def first_five_posts
    comments.order(created_at: :desc).limit(5)
  end
end
