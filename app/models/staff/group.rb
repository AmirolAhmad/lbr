class Staff::Group < ActiveRecord::Base
  belongs_to :staff_zone, class_name: 'Staff::Zone'
  has_many :staff_team_schedules, class_name: 'Staff::TeamSchedule'
end
