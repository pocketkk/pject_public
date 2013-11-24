module RostersHelper

  def user_roster
    if current_user.locations.include?(current_user.current_branch)
      roster = Roster.new(current_user).users
    else
      roster = User.active_by_branch(current_user.current_branch)
    end
  end

end
