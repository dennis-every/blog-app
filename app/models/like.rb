class Like < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'
  after_create :increment_post_likes_counter
  after_destroy :decrement_post_likes_counter

  private

  def increment_post_likes_counter
    post.increment!(:likes_counter)
  end

  def decrement_post_likes_counter
    post.decrement!(:likes_counter)
  end
end
