class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  before_validation :set_posts_counter, on: :create
  before_create :set_auth_token
  before_create :set_profile

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :author_id, dependent: :destroy
  has_many :first_three_posts, -> { order(created_at: :asc).limit(3) }, class_name: 'Post'

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

  def set_auth_token
    loop do
      self.auth_token = SecureRandom.hex
      break unless User.exists?(auth_token:)
    end
  end

  def set_profile
    self.photo = Faker::Avatar.image
    self.bio = Faker::Job.title
  end
end
