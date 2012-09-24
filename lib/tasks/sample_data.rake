namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Jason Crump",
                 email: "pocketkk@gmail.com",
                 role: "Branch Manager",
                 password: "NewLife123",
                 password_confirmation: "NewLife123",
                 current_branch: "350")
    admin.toggle!(:admin)
    User.create!( email: "logan@test.com",
                  name: "Logan Crump",
                  role: "Rebuilder",
                  password: "testing",
                  password_confirmation: "testing",
                  current_branch: "350")
 
      end
    end