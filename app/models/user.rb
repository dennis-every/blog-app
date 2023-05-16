class User < ApplicationRecord
  before_validation :set_posts_counter, on: :create

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :author_id, dependent: :destroy

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def first_3_posts
    posts.order(created_at: :asc).limit(3)
  end

  def likes?(post)
    likes.exists?(post:)
  end

  def like_for(post)
    likes.find_by(post:)
  end

  private

  def set_posts_counter
    self.posts_counter = 0
  end
end
