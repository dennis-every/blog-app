class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'
  after_save :update_post_comments_counter
  after_destroy :decrement_post_comments_counter
  validates :text, presence: true, length: { maximum: 300 }

  private

  def update_post_comments_counter
    post.increment!(:comments_counter)
  end

  def decrement_post_comments_counter
    post.decrement!(:comments_counter)
  end
end
