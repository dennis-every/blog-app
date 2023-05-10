class User < ApplicationRecord
  before_validation :set_posts_counter, on: :create

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :author_id, dependent: :destroy

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def last_3_posts
    posts.order(created_at: :desc).limit(3).reverse_order
  end

  private

  def set_posts_counter
    self.posts_counter = 0
  end
end
