require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'response status is success' do
      get users_path
      expect(response.status).to eq(200)
    end
    it 'index template was rendered' do
      get users_path
      expect(response).to render_template(:index)
    end
    it "response body includes the text 'List of users'" do
      get users_path
      expect(response.body).to include('List of users')
    end
  end

  describe 'GET /show' do
    let!(:user) { User.create(name: 'John', posts_counter: 0) }

    it 'response status is success' do
      get user_path(user.id)
      expect(response.status).to eq(200)
    end
    it 'show template was rendered' do
      get user_path(user.id)
      expect(response).to render_template(:show)
    end
    it "response body includes the text 'Bio'" do
      get user_path(user.id)
      expect(response.body).to include('Bio')
    end
  end
end
