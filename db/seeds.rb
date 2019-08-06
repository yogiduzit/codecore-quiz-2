# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

NUM_USERS = 20

Idea.delete_all
User.destroy_all

counter = 0
NUM_USERS.times do 
  counter += 1
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  user = User.new(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name}-#{last_name}-#{counter}@gmail.com",
    password: "supersecret"
  )

  if user.save
    user.ideas = rand(0..15).times.map do
      Idea.new(
        title: Faker::Hacker.say_something_smart,
        body: Faker::Hipster.paragraph(2, true, 4)
      )
    end
  end

  users = User.count
  ideas = Idea.count

  
end
p "Created #{users} users and #{ideas} ideas"