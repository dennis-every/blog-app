User.destroy_all
Post.destroy_all
Comment.destroy_all
Like.destroy_all

# 6.times { user = User.create!(name: Faker::Name.first_name, photo: Faker::Avatar.image, bio: Faker::Job.title) }

# User.all.each do |user|
#   10.times do
#     post = Post.create!(
#       title: Faker::Quotes::Shakespeare.hamlet_quote, 
#       text: Faker::Quote.matz,
#       author: user,
#       comments_counter: 0,
#       likes_counter: 0
#     )

#     10.times do 
#       author = User.order("RANDOM()").first
#       Comment.create!(text: Faker::Quotes::Shakespeare.as_you_like_it_quote, author:, post:)
#     end

#     10.times do 
#       author = User.order("RANDOM()").first
#       Like.create!(author:, post:)
#     end
#   end
# end
