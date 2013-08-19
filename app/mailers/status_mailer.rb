require 'net/http'
require 'uri'

class StatusMailer < ActionMailer::Base
    include UsersHelper
    add_template_helper(UsersHelper)
    default from: "admin@workordermachine.com"

    def mail_manager_daily(user)
        @user=user
        @todays_workorders=Workorder.today
        @todays_tasks=Task.current_user(user).due_today.task_not_completed
        mail to: user.email, content_type: 'text/html', subject: "Workorder Machine::Today"
    end

end
