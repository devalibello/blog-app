class User < ApplicationRecord
  has_many :comments
  has_many :posts, foreign_key: 'author_id'
  has_many :likes

  validates :name, presence: true
  validates :postcounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def three_most_recent_posts
    posts.order(id: :desc).limit(3)
  end
end
