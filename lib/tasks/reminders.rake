desc "Send reminders for tasks to individual users as needed"

task :send_reminders => :environment do

    puts "Checking tasks for reminders that need to be sent"

    tasks=Task.task_not_completed

    tasks.each do |task|
        if task.reminder_time
            if task.reminder_time >= Time.zone.now && task.reminder_time <= (Time.zone.now + 15.minutes)
                puts "true dat"
                puts "#{task.content}"
                puts task.taskable.email

                client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])
              unless task.taskable.phone_number.nil?
                 # Create and send an SMS message
                 client.account.sms.messages.create(
                   from: TWILIO_CONFIG['from'],
                   to: task.taskable.phone_number,
                   body: task.context << " | " << task.content << " | Sent by WOM."
                 )
            end
          end
        end
    end

end

