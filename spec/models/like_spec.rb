require 'rails_helper'

describe Like, type: :model do
  it '#update_post_likes_counter' do
    author = User.create!(name: 'test', posts_counter: 0)
    post = Post.create!(title: 'first post', comments_counter: 1, likes_counter: 1, author:)
    Like.create!(post:, author:)
    expect(post.likes_counter).to eq(2)
  end
end
