namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Jason Crump",
                 email: "pocketkk@gmail.com",
                 role: "Branch Manager",
                 password: "testing",
                 password_confirmation: "testing")
    admin.toggle!(:admin)
  6.times do |n|
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
        5.times do
          customer = "World's Best Restaurant"
          street = "12908 Washington Blvd"
          city = "Oakland"
          state = "CA"
          phone = "5106631259"
          contact = "Joseph Black"
          date = Time.now + 5.days
          duration = "4"
          misc_notes = "Key is under the mat"
          users.each { |user| user.workorders.create!(customer: customer,
                                                      street: street, 
                                                      city: city, 
                                                      state: state, 
                                                      phonenumber: phone,
                                                      contact: contact,
                                                      wo_date: date,
                                                      wo_duration: duration,
                                                      misc_notes: misc_notes) }
        end
      end
    end