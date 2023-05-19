#!/usr/bin/env ruby
require_relative 'config/environment'

# Create author
user1 = User.create!(
  email: "#{Faker::Name.first_name}@test.com",
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: Time.now,
  name: Faker::Name.first_name
)

# Create post
post = Post.create!(
  title: Faker::Quotes::Shakespeare.hamlet_quote,
  text: Faker::Quote.matz,
  author: user1
)

# Add a comment to the new post
text = Faker::Quote.matz.slice(0, 300).gsub('"', '\"')
system("curl -H 'Content-Type: application/json' \
 -H 'Authorization: #{user1.auth_token}' \
 -d '{ \"post_id\":\"#{post.id}\",\"text\":\"#{text}\"}' \
 -X POST \
 http://localhost:3000/api/v1/posts/#{post.id}/comments")

# Add execute permission to the script
system('chmod +x post_comment.rb')
