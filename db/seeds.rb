# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#

User.create!(name: "admin", email: 'admin@gmail.com', password: '111111',
             password_confirmation: '111111', admin: true)

10.times do |n|
  name = Faker::Name.first_name 
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
                email: email,
                password: password,
                )
end

create_start_day = Date.new(2023, 3, 10)
create_end_day = Date.new(2023, 3, 31)



10.times do |n|
   
  email = Faker::Internet.email
  password = "password"
  Task.create!(task_name: "万葉課題",
                detail: email,
                deadline: rand(create_start_day..create_end_day),
                priority: rand(0..2),
                status: "b",
                user_id: users.sample)
end



10.times do |n|
name = Faker::Games::Pokemon.name
Label.create!(label_name: name)
end