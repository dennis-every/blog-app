class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  after_save :update_author_posts_counter

  def last_5_comments
    comments.order(created_at: :desc).limit(5)
  end

  private
  
  def update_author_posts_counter
    author.increment!(:posts_counter)
  end
end
