require 'rails_helper'

describe Comment, type: :model do
  it '#update_post_comments_counter' do
    author = User.create!(name: 'test', posts_counter: 0)
    post = Post.create!(title: 'first post', comments_counter: 1, likes_counter: 1, author:)
    Comment.create!(post:, author:)
    expect(post.comments_counter).to eq(2)
  end
end
