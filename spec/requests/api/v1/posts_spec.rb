# spec/requests/api/v1/posts_spec.rb
require 'swagger_helper'

describe 'Posts API' do
  let(:user_id) do
    User.create!(email: "#{Faker::Name.first_name}@test.com", password: 'password',
                 password_confirmation: 'password', confirmed_at: Time.now, name: Faker::Name.first_name).id
  end

  path '/api/v1/users/{user_id}/posts' do
    get('list posts') do
      tags 'Posts'
      produces 'application/json'
      parameter name: 'user_id', in: :path, type: :string, description: 'user_id'
      response('200', 'posts found') do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   text: { type: :string },
                   comments_counter: { type: :integer },
                   likes_counter: { type: :integer },
                   author_id: { type: :integer },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' }
                 }
               }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
