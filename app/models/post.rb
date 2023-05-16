class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :last_five_comments, -> { order(created_at: :desc).limit(5) }, class_name: 'Comment'

  before_validation :set_comments_counter, on: :create
  before_validation :set_likes_counter, on: :create
  after_save :update_author_posts_counter

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  private

  def set_comments_counter
    self.comments_counter = 0
  end

  def set_likes_counter
    self.likes_counter = 0
  end

  def update_author_posts_counter
    author.increment!(:posts_counter)
  end
end
