class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  after_create :comment_counter

  def comment_counter
    post.update(commentscounter: post.comments.count)
  end
end
