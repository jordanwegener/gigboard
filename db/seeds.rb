# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def generate_gig_name
  case rand(1..5)
  when 1
    gig_name = "Show at " + Faker::Coffee.blend_name + " Cafe"
  when 2
    gig_name = "Band wanted at " + Faker::Restaurant.name
  when 3
    gig_name = Faker::Address.street_name + " Cafe - dinner music needed"
  when 4
    gig_name = "Come play music at " + Faker::Restaurant.name
  when 5
    gig_name = "Acoustic duo needed at " + Faker::Coffee.blend_name + " Bar and Brewery"
  end
  return gig_name
end

puts "Destroying old records"
User.destroy_all
puts "Seeding DB"
puts "Creating Users, Gigs and Bands"
user1 = User.create!(username: "gigs1", email: "gigs1@mail.com", password: "password")
user2 = User.create!(username: "gigs2", email: "gigs2@mail.com", password: "password")
user3 = User.create!(username: "bands1", email: "bands1@mail.com", password: "password")
user4 = User.create!(username: "bands2", email: "bands2@mail.com", password: "password")

5.times do
  user1.gigs.create!(
    title: "user1 " + generate_gig_name,
    location: (Faker::Address.street_address + ", " + Faker::Address.city),
    start_time: ((rand(1..12).to_s) + " AM"),
    end_time: ((rand(1..12).to_s) + " PM"),
    ask_price: rand(50.00..500.00),
    description: Faker::Lorem.paragraph,
    date: Faker::Date.between(from: Date.today, to: 150.days.from_now),
    active: true,
  )
end

5.times do
  user2.gigs.create!(
    title: generate_gig_name,
    location: (Faker::Address.street_address + ", " + Faker::Address.city),
    start_time: ((rand(1..12).to_s) + " AM"),
    end_time: ((rand(1..12).to_s) + " PM"),
    ask_price: rand(50.00..500.00),
    description: Faker::Lorem.paragraph,
    date: Faker::Date.between(from: Date.today, to: 150.days.from_now),
    active: true,
  )
end

# 5.times do
#   user3.gigs.create!(
#     title: generate_gig_name,
#     location: (Faker::Address.street_address + ", " + Faker::Address.city),
#     start_time: ((rand(1..12).to_s) + " AM"),
#     end_time: ((rand(1..12).to_s) + " PM"),
#     ask_price: rand(50.00..500.00),
#     description: Faker::Lorem.paragraph,
#     date: Faker::Date.between(from: Date.today, to: 150.days.from_now),
#     active: true,
#   )
# end

# 5.times do
#   user4.gigs.create!(
#     title: generate_gig_name,
#     location: (Faker::Address.street_address + ", " + Faker::Address.city),
#     start_time: ((rand(1..12).to_s) + " AM"),
#     end_time: ((rand(1..12).to_s) + " PM"),
#     ask_price: rand(50.00..500.00),
#     description: Faker::Lorem.paragraph,
#     date: Faker::Date.between(from: Date.today, to: 150.days.from_now),
#     active: true,
#   )
# end

# 3.times do
#   user1.bands.create!(
#     name: Faker::Music.band,
#     location: Faker::Address.city,
#     style: Faker::Music.genre,
#     description: Faker::Lorem.paragraph,
#   )
# end

# 3.times do
#   user2.bands.create!(
#     name: Faker::Music.band,
#     location: Faker::Address.city,
#     style: Faker::Music.genre,
#     description: Faker::Lorem.paragraph,
#   )
# end

3.times do
  user3.bands.create!(
    name: Faker::Music.band,
    location: Faker::Address.city,
    style: Faker::Music.genre,
    description: Faker::Lorem.paragraph,
  )
end

3.times do
  user4.bands.create!(
    name: Faker::Music.band,
    location: Faker::Address.city,
    style: Faker::Music.genre,
    description: Faker::Lorem.paragraph,
  )
end

puts "Seeding complete."
