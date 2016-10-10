class Staff::GroupTeam < ActiveRecord::Base
  belongs_to :team
  belongs_to :staff_group, class_name: 'Staff::Group'
  has_many :staff_team_schedules, class_name: 'Staff::TeamSchedule'
end
