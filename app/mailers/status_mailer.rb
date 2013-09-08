require 'net/http'
require 'uri'

class StatusMailer < ActionMailer::Base
    include UsersHelper
    add_template_helper(UsersHelper)
    default from: "admin@workordermachine.com"

    def mail_manager_daily(user)
        @user=user
        @todays_workorders=Workorder.today.wo_current_branch(user.current_branch)
        @tomorrows_workorders=Workorder.tomorrow.wo_current_branch(user.current_branch)
        @pastdue_workorders=user.past_due_workorders
        @assets_need_to_order = Asset.joins(:workorder).where("workorders.branch=?",user.current_branch).where('workorders.completed=?',false).where('status=?','0')
        @assets_without_serials = Asset.joins(:workorder).where("workorders.branch=?",user.current_branch).where('workorders.completed=?',false).serial_blank.order('workorders.wo_date ASC')
        @assets = [@assets_without_serials, @assets_need_to_order]
        @todays_tasks=Task.current_user(user).due_today.task_not_completed
        mail to: user.email, content_type: 'text/html', subject: "Workorder Machine::Today - ( Branch: #{user.current_branch} )"
    end

end
