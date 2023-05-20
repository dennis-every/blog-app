# spec/requests/api/v1/comments_spec.rb
require 'swagger_helper'

describe 'Comments API' do
  let(:user) do
    User.create!(email: "#{Faker::Name.first_name}@test.com", password: 'password',
                 password_confirmation: 'password', confirmed_at: Time.now, name: Faker::Name.first_name)
  end
  let(:post_id) do
    Post.create!(title: Faker::Quotes::Shakespeare.hamlet_quote, text: Faker::Quote.matz, author: user).id
  end

  path '/api/v1/posts/{post_id}/comments' do
    post('create comment') do
      tags 'Comments'
      consumes 'application/json'
      parameter name: :post_id, in: :path, type: :string
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: %w[text]
      }
      parameter name: 'Authorization', in: :header, type: :string

      response('201', 'comment created') do
        user = User.create!(
          email: "#{Faker::Name.first_name}@test.com",
          password: 'password',
          password_confirmation: 'password',
          confirmed_at: Time.now,
          name: Faker::Name.first_name
        )
        let(:comment) { { text: 'test', author: user, post_id: } }
        let(:Authorization) { user.auth_token }
        run_test!
      end
    end
  end

  path '/api/v1/posts/{post_id}/comments' do
    get('list comments') do
      tags 'Comments'
      produces 'application/json'
      parameter name: 'post_id', in: :path, type: :string, description: 'post_id'
      response('200', 'comments found') do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   post_id: { type: :integer },
                   text: { type: :string },
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
