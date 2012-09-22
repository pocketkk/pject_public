namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Jason Crump",
                 email: "pocketkk@gmail.com",
                 role: "Branch Manager",
                 password: "testing",
                 password_confirmation: "testing",
                 current_branch: "350")
    admin.toggle!(:admin)
    User.create!( email: "logan@test.com",
                  name: "Logan Crump",
                  role: "Rebuilder",
                  password: "testing",
                  password_confirmation: "testing"
                  current_branch: "350")
  5.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      role = 'Sales'
      current_branch="340"
      User.create!(name: name,
                   email: email,
                   role: role,
                   password: password,
                   password_confirmation: password,
                   current_branch: current_branch)
    end
  
    users = User.all(limit: 7)
        2.times do
          customer = "World's Best Restaurant"
          street = "12908 Washington Blvd"
          city = "Oakland"
          state = "CA"
          phone = 5106631259
          contact = "Joseph Black"
          date = Time.now + 5.days
          duration = "4"
          misc_notes = "Key is under the mat"
          branch = "350"
          users.each { |user| user.workorders.create!(customer: customer,
                                                      street: street, 
                                                      city: city, 
                                                      state: state, 
                                                      phonenumber: phone,
                                                      contact: contact,
                                                      wo_date: date,
                                                      wo_duration: duration,
                                                      misc_notes: misc_notes,
                                                      branch: branch) }
        end
      end
    end