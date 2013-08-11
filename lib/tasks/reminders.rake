desc "Send reminders for tasks to individual users as needed"

task :send_reminders => :environment do

  puts "Checking tasks for reminders that need to be sent"

  tasks=Task.task_not_completed

  puts tasks

  tasks.each do |task|
    if task.reminder_time
      if task.reminder_time >= Time.zone.now && task.reminder_time <= (Time.zone.now + 10.minutes)
        if task.assigned_to != task.taskable_id
          user=User.find(task.assigned_to)
          @users_to_text = [user, task.taskable]
        else
          @users_to_text = [task.taskable]
        end
        @users_to_text.each do |u|
          send_text(u, task)
        end
      end
    end
  end
end

def send_text(user, task)
  client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token']) if user.phone_number
  # Create and send an SMS message
  client.account.sms.messages.create(
    from: TWILIO_CONFIG['from'],
    to: user.phone_number,
    body: task.reminder_msg
  ) if client
end
