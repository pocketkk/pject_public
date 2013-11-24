module RostersHelper
  def user_roster
    roster=Roster.new(current_user).users
  end
end
