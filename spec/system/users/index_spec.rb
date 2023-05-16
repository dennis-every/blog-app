require 'rails_helper'

describe 'Users index page', type: :system do
  describe 'checks the content of the users#index page' do
    before(:each) do
      @user_one = User.create(name: 'Dennis', photo: "https://robohash.org/idquiet.png?size=300x300&set=set1", bio: 'software developer')
      @user_two = User.create(name: 'Neville', photo: "https://robohash.org/adipiscivoluptatesea.png?size=300x300&set=set1", bio: 'data scientist')
      @post_one = Post.create!(title: Faker::Quotes::Shakespeare.hamlet_quote, text: Faker::Quote.matz, author: @user_one)
      @post_two = Post.create!(title: Faker::Quotes::Shakespeare.hamlet_quote, text: Faker::Quote.matz, author: @user_one)
    end
    
    it 'expects to see the username of all other users' do
      visit root_path

      expect(page).to have_content('Dennis')
      expect(page).to have_content('Neville')
    end

    it 'expects to see the profile picture for each user' do
      visit root_path

      expect(page).to have_css("img[src*='#{@user_one.photo}']")
      expect(page).to have_css("img[src*='#{@user_two.photo}']")
    end

    it 'expects to see the number of posts each user has written' do
      visit root_path

      expect(page).to have_content("Number of posts: #{@user_one.posts.size}")
      expect(page).to have_content("Number of posts: #{@user_two.posts.size}")
    end

    it "expects on click on a user to redirect to that user's show page" do
      visit root_path

      click_link 'Dennis'
      expect(page).to have_current_path(user_path(@user_one))
    end
  end
end
