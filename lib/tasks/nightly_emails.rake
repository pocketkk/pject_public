desc "Send emails to Branch Managers nightly."

task :send_daily_emails => :environment do

  puts "Checking for users to send emails to"

  users=User.managers.receives_emails

  puts users

  users.each do |user|
    StatusMailer.mail_manager_daily(user).deliver
  end

end
