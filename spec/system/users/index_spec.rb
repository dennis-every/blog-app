require 'rails_helper'

describe 'Users index page', type: :system do
  describe 'checks the content of the users#index page' do
    before(:each) do
      @user1 = User.create(name: 'Dennis', photo: 'https://robohash.org/idquiet.png', bio: 'software developer')
      @user2 = User.create(name: 'Neville', photo: 'https://robohash.org/adipiscivoluptatesea.png', bio: 'coder')
      @post1 = Post.create(title: Faker::Quotes::Shakespeare.hamlet_quote, text: Faker::Quote.matz, author: @user1)
      @post2 = Post.create(title: Faker::Quotes::Shakespeare.hamlet_quote, text: Faker::Quote.matz, author: @user1)
    end

    it 'expects to see the username of all other users' do
      visit root_path

      expect(page).to have_content('Dennis')
      expect(page).to have_content('Neville')
    end

    it 'expects to see the profile picture for each user' do
      visit root_path

      expect(page).to have_css("img[src*='#{@user1.photo}']")
      expect(page).to have_css("img[src*='#{@user2.photo}']")
    end

    it 'expects to see the number of posts each user has written' do
      visit root_path

      expect(page).to have_content("Number of posts: #{@user1.posts.size}")
      expect(page).to have_content("Number of posts: #{@user2.posts.size}")
    end

    it "expects on click on a user to redirect to that user's show page" do
      visit root_path

      click_link 'Dennis'
      expect(page).to have_current_path(user_path(@user1))
    end
  end
end
