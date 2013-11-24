class Roster
  def initialize(user)
    @user = user
    @roster ||= []
  end

  def users
    users_combined_by_branch.uniq
  end

  def users_combined_by_branch
    roster = @user.locations.map do |branch|
      Branch.includes(:user).where(branch_number: branch).merge(User.active)
    end
    @roster = combine_roster(roster.flatten)
  end

  def combine_roster(roster)
    roster.map(&:user)
  end

  def branches
    @user.locations
  end

end
