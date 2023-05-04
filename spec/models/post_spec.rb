require 'rails_helper'

describe Post, type: :model do
  author = User.new(name: 'John')

  describe 'Title' do
    it 'not valid if blank' do
      post = Post.new(title: nil, author:)
      expect(post).to_not be_valid
    end

    it 'valid if not blank' do
      post = Post.new(title: 'test', author:)
      expect(post).to be_valid
    end

    it 'not valid if exceeds 250 characters' do
      post = Post.new(title: 'a' * 251, author:)
      expect(post).to_not be_valid
    end
  end

  describe 'CommentsCounter' do
    it 'is not valid if it is not an integer greater than or equal to zero' do
      post = Post.new(title: 'test', comments_counter: -1, author:)
      expect(post).to_not be_valid
    end

    it 'is valid if it is an integer greater than or equal to zero' do
      post = Post.new(title: 'test', comments_counter: 0, author:)
      expect(post).to be_valid
    end
  end

  describe 'LikesCounter' do
    it 'is not valid if it is not an integer greater than or equal to zero' do
      post = Post.new(title: 'test', likes_counter: -1, author:)
      expect(post).to_not be_valid
    end

    it 'is valid if it is an integer greater than or equal to zero' do
      post = Post.new(title: 'test', likes_counter: 0, author:)
      expect(post).to be_valid
    end
  end
end
