# to run -> bundle exec rake db:populate
# user, role="Sales", quantity=1

def create_seed_workorder(args)

  user = args[:user]
  role = args[:role] || "Sales"
  quantity = args[:repeat] || 1

  quantity.times do
    restaurant_suffixes = ["'s Bistro", "'s Place", "'s Restaurant",
                           "'s", "'s Bar", "'s Tavern"]
    customer =    Faker::Name.first_name + restaurant_suffixes[Random.rand(6)]
    street =      Faker::Address.street_address
    city =        Faker::Address.city
    state =       Faker::Address.us_state_abbr
    phonenumber = '555' + (Random.rand(100)+300).to_s + (Random.rand(100)+2000).to_s
    contact =     Faker::Name.name
    misc_notes =  Faker::Company.catch_phrase
    wo_branch =   user.current_branch
    types =       ["New Install", "Swap", "Pull", "Follow Up"]
    wo_type =     types[Random.rand(4)]
    duration =    1 + Random.rand(6)
    before_or_after = Random.rand(2)
    need_to_order = Random.rand(10)
    if before_or_after == 0
      wo_date = Time.zone.now - Random.rand(30).days
      completed = true
    else
      if need_to_order == 1
        wo_date = ""
      else
        wo_date = Time.zone.now + Random.rand(30).days
      end
      completed = false
    end

    workorder = user.workorders.build(
      customer: customer,
      street: street,
      city: city,
      state: state,
      phonenumber: phonenumber,
      contact: contact,
      misc_notes: misc_notes,
      wo_type: wo_type,
      wo_duration: duration,
      wo_date: wo_date,
      branch: wo_branch,
      completed: completed
    )
    workorder.save
    repeat = Random.rand(3)
    create_seed_asset({:workorder => workorder, :repeat => repeat})
  end
end

def create_seed_asset(args)
  workorder = args[:workorder]
  quantity = args[:repeat] || 1

  quantity.times do
    name_options = ["A4", "D2", "ET", "A5", "U34"]
    name = name_options[Random.rand(5)]
    serial_status = Random.rand(4)
    if serial_status == 1
      serial = ""
    else
      serial = "AB234565"
    end
    status_options = ["","0","1","10","97","2","11","25","76","98","99","100"]
    status = status_options[Random.rand(12)]
    wo = workorder.assets.build(name: name, serial: serial, status: status)
    wo.save
  end
end

def create_seed_dayoff(args)
  user = args[:user]
  quantity = args[:repeat] || 1

  quantity.times do
    start_date = Time.zone.now + Random.rand(120).days
    end_date = start_date + Random.rand(14).days
    approved_test = Random.rand(6)
    if approved_test == 1
      approved = false
    else
      approved = true
    end
    do_types = ["Vacation", "Other", "Floating Holiday"]
    do_type = do_types[Random.rand(3)]
    day_off = user.day_offs.build(start_date: start_date, end_date: end_date,
                      do_type: do_type, approved: approved)
    day_off.save
  end
end

def create_seed_part(args)
  user = args[:user]
  quantity = args[:repeat] || 1

  quantity.times do
    part_types = ["Do-Hicky", "Thingamagig", "Do-Dad", "Fluximator"]
    part_type = part_types[Random.rand(4)]
    name = Faker::Name.first_name + " " + part_type
    qty = Random.rand(5) + 1
    branch = user.current_branch
    part = user.parts.build(name: name, qty: qty, ordered: false, branch: branch)
    part.save
  end
end



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
    logan = User.create!( email: "logan@test.com",
                  name: "Logan Crump",
                  role: "Rebuilder",
                  password: "testing",
                  password_confirmation: "testing",
                  current_branch: "350")

    ["350","340","330","320","310"].each do |branch|
      1.times do |n|
        name  = Faker::Name.first_name + " " + Faker::Name.last_name
        email = Faker::Internet.email
        password  = "password"
        role = "Branch Manager"
        current_branch = branch
        user = User.create!(name: name,
                     email: email,
                     password: password,
                     password_confirmation: password,
                     current_branch: current_branch,
                     role: role)
        #workorder seed data / create 3 workorders
        create_seed_workorder({:user => user, :role => role, :repeat => 3})
        create_seed_dayoff({:user => user, :repeat => 2})
        create_seed_part({:user => user, :repeat => 2})
      end

      1.times do |n|
        name  = Faker::Name.first_name + " " + Faker::Name.last_name
        email = Faker::Internet.email
        password  = "password"
        role = "Regional Manager"
        current_branch = branch
        user = User.create!(name: name,
                     email: email,
                     password: password,
                     password_confirmation: password,
                     current_branch: current_branch,
                     role: role)
        create_seed_workorder({:user => user, :role => role, :repeat => 3})
        create_seed_dayoff({:user => user, :repeat => 2})
        create_seed_part({:user => user, :repeat => 2})
      end

      1.times do |n|
        name  = Faker::Name.first_name + " " + Faker::Name.last_name
        email = Faker::Internet.email
        password  = "password"
        role = "Installer"
        current_branch = branch
        user = User.create!(name: name,
                     email: email,
                     password: password,
                     password_confirmation: password,
                     current_branch: current_branch,
                     role: role)
        create_seed_workorder({:user => user, :role => role, :repeat => 3})
        create_seed_dayoff({:user => user, :repeat => 2})
        create_seed_part({:user => user, :repeat => 2})
      end

      1.times do |n|
        name  = Faker::Name.first_name + " " + Faker::Name.last_name
        email = Faker::Internet.email
        password  = "password"
        role = "Rebuilder"
        current_branch = branch
        user = User.create!(name: name,
                     email: email,
                     password: password,
                     password_confirmation: password,
                     current_branch: current_branch,
                     role: role)
        create_seed_dayoff({:user => user, :repeat => 2})
        create_seed_part({:user => user, :repeat => 2})
      end

      2.times do |n|
        name  = Faker::Name.first_name + " " + Faker::Name.last_name
        email = Faker::Internet.email
        password  = "password"
        role = "Sales"
        current_branch = branch
        user = User.create!(name: name,
                     email: email,
                     password: password,
                     password_confirmation: password,
                     current_branch: current_branch,
                     role: role)
        create_seed_workorder({:user => user, :role => role, :repeat => 7})
        create_seed_dayoff({:user => user, :repeat => 2})
        create_seed_part({:user => user, :repeat => 2})

      end

      7.times do |n|
        name  = Faker::Name.first_name + " " + Faker::Name.last_name
        email = Faker::Internet.email
        password  = "password"
        role = "SSR"
        current_branch = branch
        user = User.create!(name: name,
                     email: email,
                     password: password,
                     password_confirmation: password,
                     current_branch: current_branch,
                     role: role)
        create_seed_workorder({:user => user, :role => role, :repeat => 3})
        create_seed_dayoff({:user => user, :repeat => 2})
        create_seed_part({:user => user, :repeat => 2})
      end
    end
  end
end

