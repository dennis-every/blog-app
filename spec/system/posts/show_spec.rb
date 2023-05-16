require 'rails_helper'

describe 'Post show page', type: :system do
  describe 'checks the content of the posts#show page' do
    before(:each) do
      @user1 = User.create(name: 'Dennis', photo: 'https://robohash.org/idquiet.png', bio: 'developer')
      @user2 = User.create(name: 'Neville', photo: 'https://robohash.org/idquiet.png', bio: 'coder')
      @post1 = Post.create!(title: Faker::Quotes::Shakespeare.hamlet_quote, text: Faker::Quote.matz, author: @user1)
      @comment1 = Comment.create!(text: Faker::Quotes::Shakespeare.as_you_like_it_quote, author: @user1, post: @post1)
      @comment2 = Comment.create!(text: Faker::Quotes::Shakespeare.as_you_like_it_quote, author: @user2, post: @post1)
    end

    it "expects to see the post's title" do
      visit post_path(@post1)

      expect(page).to have_content(@post1.title)
    end

    it 'expects to see who wrote the post' do
      visit post_path(@post1)

      expect(page).to have_content("Post by #{@post1.author.name}")
    end

    it 'expects to see how many comments it has' do
      visit post_path(@post1)

      expect(page).to have_content("Comments #{@post1.comments.size}")
    end

    it 'expects to see how many likes it has' do
      visit post_path(@post1)

      expect(page).to have_content("Likes #{@post1.likes.size}")
    end

    it 'expects to see the post body' do
      visit post_path(@post1)

      expect(page).to have_content(@post1.text)
    end

    it 'expects to see the username of each commentor' do
      visit post_path(@post1)

      expect(page).to have_content(@comment1.author.name)
      expect(page).to have_content(@comment2.author.name)
    end

    it 'expects to see the comment each commentor left' do
      visit post_path(@post1)

      expect(page).to have_content(@comment1.text)
      expect(page).to have_content(@comment2.text)
    end
  end
end
