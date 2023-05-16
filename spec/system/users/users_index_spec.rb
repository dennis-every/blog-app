require 'rails_helper'

RSpec.describe 'User index specs', type: :system do
  describe 'check the content of the index page' do
    before(:each) do
        @user_one = User.create(name: 'Dennis', photo: 'pic.jpg', bio: 'software developer', posts_counter: 0)
        @user_two = User.create(name: 'Neville', photo: 'pic.jpg', bio: 'data scientist', posts_counter: 0)
    end

    it 'should show the index page' do
      visit root_path
      expect(page).to have_content('List of users')
    end

    it 'profile picture for each user.' do
      visit root_path
      expect(page).to have_selector('img')
    end

    it 'I can see the list of all users in the index' do
      visit root_path
      expect(page).to have_content('Dennis')
      expect(page).to have_content('Neville')
    end

    it 'the number of posts each user has written' do
      visit root_path
      expect(page).to have_content('Number of posts:')
    end

    it 'I can see the list of all users in the index' do
      visit root_path
      click_link 'Dennis'
      expect(page).to have_content('software developer')
    end
  end
end