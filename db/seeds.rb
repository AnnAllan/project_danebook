
User.destroy_all
Profile.destroy_all
Post.destroy_all
Like.destroy_all
Comment.destroy_all

MULTIPLIER = 10

#create users
MULTIPLIER.times do
  User.create( first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              password: "password",
              password_confirmation: "password")
end

puts "10 Users created"

users = User.all
#create profiles

users.each do |user|
  user.profile.update( college: "#{Faker::StarWars.planet} University",
                        hometown: Faker::GameOfThrones.city,
                        location: Faker::RickAndMorty.location,
                        motto: Faker::DrWho.quote,
                        about: Faker::HitchhikersGuideToTheGalaxy.quote,
                        dob_day: Faker::Number.between(1, 28),
                        dob_month: Faker::Number.between(1, 12),
                        dob_year: Faker::Number.between(1930, 2003))
end

puts "Profiles created for each user"

#create posts
(MULTIPLIER*3).times do
  users.sample.posts.create(content: Faker::FamilyGuy.quote)
end

posts = Post.all

puts "30 posts created"

#create comments

(MULTIPLIER*3).times do
  posts.sample.comments.create(user_id: users.sample.id,
                              content: Faker::RickAndMorty.quote)
end

comments = Comment.all

puts "30 comments created"

#create likes
(MULTIPLIER*5).times do
  liker_id = users.sample.id
  posts.sample.likes.create( user_id: liker_id)
  comments.sample.likes.create(user_id: liker_id)
end

puts "50 likes created"
puts "Seeding complete"
