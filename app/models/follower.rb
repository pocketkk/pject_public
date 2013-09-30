class Follower < ActiveRecord::Base
  attr_accessible :followable_id, :followable_type, :user_id
  belongs_to :followable, polymorphic: true


  def user
    User.find(self.user_id)
  end

end
