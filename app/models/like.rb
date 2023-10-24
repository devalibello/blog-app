class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  after_create :like_counter

  def like_counter
    post.update(likescounter: post.likes.count)
  end
end
