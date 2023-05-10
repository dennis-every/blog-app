require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:user) { User.create(name: 'John', posts_counter: 0) }

  describe 'GET /index' do
    it 'response status is success' do
      get user_posts_path(user)
      expect(response.status).to eq(200)
    end
    it 'index template was rendered' do
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end
    it "response body includes the text 'List of posts'" do
      get user_posts_path(user)
      expect(response.body).to include('List of posts')
    end
  end

  describe 'GET /show' do
    let!(:post) { Post.create(author: user, title: 'Post title', comments_counter: 0, likes_counter: 0) }

    it 'response status is success' do
      get user_post_path(user, post)
      expect(response.status).to eq(200)
    end
    it 'show template was rendered' do
      get user_post_path(user, post)
      expect(response).to render_template(:show)
    end
    it "response body includes the text 'Post by'" do
      get user_post_path(user, post)
      expect(response.body).to include('Post by')
    end
  end
end
