class DayOff < ActiveRecord::Base
  attr_accessible :start_date, :end_date, :do_type, :user_id, :approved
  belongs_to :user

end
