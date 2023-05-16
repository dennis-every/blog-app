require 'rails_helper'

describe 'Post index page', type: :system do
  describe 'checks the content of the posts#index page' do
    before(:each) do
      @user1 = User.create(name: 'Dennis', photo: 'https://robohash.org/idquiet.png', bio: 'developer')
      @user2 = User.create(name: 'Neville', photo: 'https://robohash.org/idquiet.png', bio: 'coder')
      @post1 = Post.create!(title: Faker::Quotes::Shakespeare.hamlet_quote, text: Faker::Quote.matz, author: @user1)
      @post2 = Post.create!(title: Faker::Quotes::Shakespeare.hamlet_quote, text: Faker::Quote.matz, author: @user1)
      @post3 = Post.create!(title: Faker::Quotes::Shakespeare.hamlet_quote, text: Faker::Quote.matz, author: @user1)
      @post4 = Post.create!(title: Faker::Quotes::Shakespeare.hamlet_quote, text: Faker::Quote.matz, author: @user1)
      @comment1 = Comment.create!(text: Faker::Quotes::Shakespeare.as_you_like_it_quote, author: @user1, post: @post1)
      @comment2 = Comment.create!(text: Faker::Quotes::Shakespeare.as_you_like_it_quote, author: @user2, post: @post1)
      @like1 = Like.create!(author: @user2, post: @post1)
    end

    it "expects to see the user's profile picture" do
      visit user_posts_path(@user1)

      expect(page).to have_css("img[src*='#{@user1.photo}']")
    end

    it "expects to see the user's username" do
      visit user_posts_path(@user1)

      expect(page).to have_content(@user1.name)
    end

    it 'expects to see the number of posts the user has written' do
      visit user_posts_path(@user1)

      expect(page).to have_content("Number of posts: #{@user1.posts.size}")
    end

    it "expects to see a post's title" do
      visit user_posts_path(@user1)

      expect(page).to have_content(@post1.title)
    end

    it "expects to see some of the post's body" do
      visit user_posts_path(@user1)

      expect(page).to have_content(@post1.text)
    end

    it 'expects to see the first comment on a post' do
      visit user_posts_path(@user1)

      expect(page).to have_content(@comment1.text)
    end

    it 'expects to see how many comments a post has' do
      visit user_posts_path(@user1)

      expect(page).to have_content("Comments #{@post1.comments.size}")
    end

    it 'expects to see how many likes a post has' do
      visit user_posts_path(@user1)

      expect(page).to have_content("Likes #{@post1.likes.size}")
    end

    it 'expects to see a section for pagination if there are more posts than fit on the view' do
      visit user_posts_path(@user1)

      expect(page).to have_content('Pagination')
    end

    it "expects on click on a post, it redirects me to that post's show page" do
      visit user_posts_path(@user1)

      click_link @post1.title
      expect(page).to have_current_path(post_path(@post1))
    end
  end
end
