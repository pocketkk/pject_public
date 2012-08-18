namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Jason Crump",
                 email: "pocketkk@gmail.com",
                 role: "Branch Manager",
                 password: "testing",
                 password_confirmation: "testing")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      role = 'Sales'
      User.create!(name: name,
                   email: email,
                   role: role,
                   password: password,
                   password_confirmation: password)
    end
  
    users = User.all(limit: 6)
        50.times do
          content = "World's Best Restaurant"
          users.each { |user| user.workorders.create!(customer: content) }
        end
      end
    end